class SchoolsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @school = School.new
    @all_schools= School.all
  end

  def create
  	@school = School.new(name: params[:school][:name])
  		
  	if @school.save
  		redirect_to schools_path
  	else
      logger.info("Attempt to save school with name: '#{@school.name}' failed.")

      @all_schools = School.all
      render :index
  	end
  end

end
