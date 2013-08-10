require 'csv'

class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @school = School.find(params[:school_id])
    
    @user = User.new(school: @school)
    @users = @school.users.order(:firstname).order(:is_teacher)
  end

  def create
    params.permit!
    @user = User.create!(params[:user].merge(school_id: params[:school_id]))
    redirect_to school_users_path(school_id: params[:school_id]), notice: "User was created successfully."
  rescue
    logger.info("Failed to create user!")

    @school = School.find(params[:school_id])
    @users = @school.users.order(:firstname).order(:is_teacher)

    flash.now[:alert] = "Failed to create user"
    render :index
  end
  
  def bulk_add
    users = CSV.parse(params[:file].read, :headers => true)
    users.each do |row|
      User.create!(row.to_hash.merge(school_id: params[:school_id]))
    end
    redirect_to school_users_path(params[:school_id]), notice: "#{users.size} users created"
  rescue
    redirect_to school_users_path(params[:school_id]), alert: "Invalid CSV file uploaded"
  end
end
