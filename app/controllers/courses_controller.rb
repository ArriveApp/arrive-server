class CoursesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @school = School.find(params[:school_id])
    
    @course = Course.new(school: @school)
    @courses = @school.courses
  end

  def create
    school_id = params[:school_id]

    @course = Course.new(name: params[:course][:name], school_id: school_id)

  	if @course.save
  		redirect_to school_courses_path(school_id: school_id), notice: 'Class was created successfully'
  	else
      logger.info("Attempt to save class with name: '#{@course.name}' failed.")

      @school = School.find(school_id)
      @courses = @school.courses

      flash.now[:alert] = 'Failed to create class'
      render :index
  	end
  end

end

