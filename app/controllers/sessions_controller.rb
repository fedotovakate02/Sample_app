class SessionsController < ApplicationController
  def new
  end

 def create
  user = User.find_by(email: params[:session][:email].downcase)
if user && user.authenticate(params[:session][:password])
# Log the user in and redirect to the user's show page.
redirect_to user
else
flash[:danger] = 'Invalid email/password combination'
# Create an error message.
render 'new'
end
end
end
