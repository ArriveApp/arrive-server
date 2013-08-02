class UsersController < ApplicationController
  def index
  	@newuser = User.create
  end
  def create
  	@newuser = User.create(name: params[:email][:school_id][:username][:password][:password_confirmation][:firstname][:lastname])
  	if @newuser.save
  		puts @newuser
  		logger.error @newuser
  		redirect_to users_path
  	else
  		logger.info("Failed to create user #{@newuser.name}")
  		redirect_to users_path
  	end
  end
end
