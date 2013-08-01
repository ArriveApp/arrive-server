class CoursesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @course = Course.new
    @all_courses = Course.all
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

end
