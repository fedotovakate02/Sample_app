class AccountActivationsController < ApplicationController
	def edit
			 user = User.find_by(email: params[:email])
			
			if user && !user.activated? && user.authenticated?(:activation, params[:id]) 
			user.activate
			log_in user
		  flash[:success] = "Пользователь успешно создан!"
		  redirect_to user
		end
	end
end
