class CoursesController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html
  respond_to :json, only: :index

  def index
    @school = School.find(params[:school_id])

    @course = Course.new(school: @school)
    @courses = @school.courses

    respond_with(@courses)
  end

  def create
    school_id = params[:school_id]

    @course = Course.new(name: params[:course][:name], school_id: school_id)

  	if @course.save
  		redirect_to school_courses_path(school_id: school_id), notice: 'Course was created successfully'
  	else
      logger.info("Attempt to save course with name: '#{@course.name}' failed.")

      @school = School.find(school_id)
      @courses = @school.courses

      flash.now[:alert] = 'Failed to create a course'
      render :index
  	end
  end

end

