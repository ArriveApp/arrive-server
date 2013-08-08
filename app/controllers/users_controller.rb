class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @school = School.find(params[:school_id])
    @user = User.new(school: @school)
    @users = @school.users
  end

  def create
    user_params = params[:user]
    school_id = params[:school_id]

    @user = User.new(firstname: user_params[:firstname], lastname: user_params[:lastname], email: user_params[:email], password: user_params[:password], school_id: school_id)

    if @user.save
  		redirect_to school_users_path(school_id: school_id), notice: "User was created successfully."
  	else
  		logger.info("Failed to create user!")

      @school = School.find(school_id)
      @users = @school.users

      flash.now[:alert] = "Failed to create user"
  		render :index
  	end
  end
end
