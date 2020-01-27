class SessionsController < ApplicationController
	include SessionsHelper
  def new
  end

 def create
  user = User.find_by(email: params[:session][:email].downcase)
if user && user.authenticate(params[:session][:password])
# Log the user in and redirect to the user's show page.
log_in(user)
remember(user)
redirect_to user
else
flash[:danger] = 'Invalid email/password combination'

# Create an error message.
render 'new'
end
end

def destroy
log_out
flash[:danger] = 'Пользователь удален!'
redirect_to root_url

end
end
