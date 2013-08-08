class SchoolsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :create]

  def index
    @school = School.new
    @schools= School.all
  end

  def create
  	@school = School.new(name: params[:school][:name])
  		
  	if @school.save
  		redirect_to schools_path
  	else
      logger.info("Attempt to save school with name: '#{@school.name}' failed.")

      @schools = School.all
      render :index
  	end
  end
end
