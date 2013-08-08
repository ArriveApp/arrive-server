class CoursesController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html
  respond_to :json, only: :index

  def index
    school = School.find(params[:school_id])

    @course = Course.new(school_id: school.id)
    @courses = school.courses

    respond_with(@courses)
  end

  def create
    school = School.find(params[:school_id])

    @course = school.courses.build(name: params[:course][:name])

  	if @course.save
  		redirect_to school_courses_path(school_id: school.id)
  	else
      logger.info("Attempt to save course with name: '#{@course.name}' failed.")

      @courses = school.courses
      render :index
  	end
  end

end

