require 'csv'

class UsersController < ApplicationController
  before_filter :authorized?

  def index
    @school = School.find(params[:school_id])

    @user = User.new(school: @school, is_teacher: false)
    @users = @school.users.order(:firstname).order(:is_teacher)
  end

  def create
    params.permit!
    @user = User.new(params[:user].merge(school_id: params[:school_id], pin: params[:user][:password]))
    if @user.save
      redirect_to school_users_path(school_id: params[:school_id]), notice: "User was created successfully."
      return
    end

    logger.info("Failed to create user!")

    @school = School.find(params[:school_id])
    @users = @school.users.order(:firstname).order(:is_teacher)

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
end
