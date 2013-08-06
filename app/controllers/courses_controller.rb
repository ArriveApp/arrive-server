class CoursesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @course = Course.new
    @all_courses = Course.joins(:school).where(school_id: current_user.school)
  end

  def create
  	@course = Course.new(name: params[:course][:name], school: current_user.school)

  	if @course.save
  		redirect_to courses_path
  	else
      logger.info("Attempt to save course with name: '#{@course.name}' failed.")
      @all_courses = Course.all
      render :index
  	end
  end

  def courses_for_school
    @school_id = params[:id]
    schools_courses = Course.joins(:school).where(school_id: @school_id)
    render :json => schools_courses
  end

  def get
    render :json => Course.all
  end

end

