require 'csv'

class UsersController < ApplicationController
  before_filter :authorized?

  def index
    @school = School.find(params[:school_id])
    @user = User.new(school: @school, is_teacher: false)

    @users = @school.users.where(:is_deleted => false).order(:firstname).order(:is_teacher)
    @courses = @school.courses.order(:name)

  end

  def create
    params.permit!
    courses_to_attend = ""

    if !params[:courses_ids].nil?
      courses_to_attend = params[:courses_ids].join("|")
    end

    @user = User.new(params[:user].merge(school_id: params[:school_id], pin: params[:user][:password], courses: courses_to_attend))

    if @user.save
      redirect_to school_users_path(school_id: params[:school_id]), notice: "User was created successfully"
      return
    end
    logger.info("Failed to create user!")
    @school = School.find(params[:school_id])
    @users = @school.users.order(:firstname).order(:is_teacher)
    @courses = @school.courses.order(:name)

    flash.now[:alert] = "Failed to create user"
    render :index
  end

  def bulk_add
    users = CSV.parse(params[:file].read, :headers => true)
    users.each do |row|
      User.create!(row.to_hash.merge(school_id: params[:school_id], pin: row['password']))
    end
    redirect_to school_users_path(params[:school_id]), notice: "#{users.size} users created"
  rescue
    redirect_to school_users_path(params[:school_id]), alert: "Invalid CSV file uploaded"
  end

  def destroy
    user_to_delete = User.find(params[:id])

    if current_user.can_delete user_to_delete
      User.find(params[:id]).update_attributes(:is_deleted => true)
    end

    redirect_to school_users_path(params[:school_id])
  end
end
