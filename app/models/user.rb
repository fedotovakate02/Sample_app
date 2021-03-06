class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token
		#VALID_EMAIL_REGEX = /\A\w+@\w+\.[a-z]+\z/i
	before_save :to_lower_case
	before_create :create_activation_digest
 validates :name, presence:true, length: {maximum:50}
 # validates :email,	format: {with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false} 

has_secure_password	 

def self.new_token
SecureRandom.urlsafe_base64
end   

def self.digest(string)
cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
BCrypt::Password.create(string, cost: cost)
end      
	  
	  def remember
self.remember_token = User.new_token
update_attribute(:remember_digest, User.digest(remember_token))
end    

def authenticated?(attribute, token)
	digest = self.send("#{attribute}_digest")
	return false if digest.nil?
	BCrypt::Password.new(digest).is_password?(token)

end

def forget
update_attribute(:remember_digest, nil)
end    

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def activate
		update(activated: true, activated_at: Time.now)
	end

	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end
	# Sends password reset email.
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end 

private

  def to_lower_case
  self.email = email.downcase
  end

  def create_activation_digest
  	self.activation_token = User.new_token
		self.activation_digest = User.digest(activation_token)
	end


end
