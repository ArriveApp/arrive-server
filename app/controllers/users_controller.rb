class UsersController < ApplicationController
  def index
  	@newuser = User.create
  end
  def create
  	@newuser = User.new(firstname: params[:user][:firstname], lastname: params[:user][:lastname], email: params[:user][:email], password: params[:user][:password], :school => current_user.school)
    if @newuser.save
  		puts @newuser
  		logger.error @newuser
  		redirect_to users_path, notice: "user created"
  	else
  		logger.info("Failed to create user #{@newuser.firstname}")
  		redirect_to users_path, alert: "failed to create user"
  	end
  end
end
