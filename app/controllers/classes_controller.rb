class ClassesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @classes = Classes.new
    @all_classes = Classes.all
  end

  def create
  	@classes = Classes.new(name: params[:classes][:name])
  		
  	if @classes.save
  		redirect_to classes_path
  	else
      logger.info("Attempt to save class with name: '#{@classes.name}' failed.")

      @all_classes = Classes.all
      render :index
  	end
  end

end