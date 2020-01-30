class UsersController < ApplicationController
	
	before_action :logged_in_user, only: [:edit, :update]
	before_action :correct_user, only: [:edit, :update]
  def new
   @user = User.new
  end
  
  	def index
			@users = User.paginate(page: params[:page], per_page: 10)
		end

  def show
  	@user = User.find(params[:id] )
  end

  def create
	  @user = User.new(user_params)
		  if @user.save
		  	log_in @user
		  	flash[:success] = "Пользователь успешно создан!"
		  	redirect_to @user
			 else
			  render 'new'
		  end
 end

	def edit
		logged_in_user
		#@user = User.find(params[:id])
	end

	def update
		logged_in_user
	  @user = User.find(params[:id])
		if @user.update(user_params)
		flash[:success] = "Пользователь успешно обнавлен!"
		redirect_to @user
			else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
		flash[:success] = "Пользователь успешно удален!"
		redirect_to users_url
	else
		flash[:danger] = "Пользователь не удален!"
		redirect_to users_url
	end
end

private

	def user_params 
	 	params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def logged_in_user
		unless logged_in?
		flash[:danger] = "Please log in."
		redirect_to sessions_new_url
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless @user == current_user
	end
end
