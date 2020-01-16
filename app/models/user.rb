class User < ApplicationRecord
	VALID_EMAIL_REGEX = /\A\w+@\w+\.[a-z]+\z/i
	before_save :to_lower_case
	validates :name, presence:true, length: {maximum:50}
	validates :email,	format: {with: VALID_EMAIL_REGEX },
	          uniqueness: {case_sensitive: false} 

has_secure_password	          
	          
private

  def to_lower_case
  self.email = email.downcase
  end
end
