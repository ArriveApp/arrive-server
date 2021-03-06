class SchoolsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @school = School.new
    @schools = School.all.order(:name)
  end

  def create
  	@school = School.new(name: params[:school][:name])
  		
  	if @school.save
  		redirect_to schools_path, notice: 'School was created successfully'
  	else
      logger.info("Attempt to save school with name: '#{@school.name}' failed.")

      @schools = School.all.order(:name)

      flash.now[:alert] = 'Failed to create school'
      render :index
  	end
  end

end
