class ClassesController < ApplicationController
  before_filter :authenticate_user!

  def create
  	@class = Classes.new(:name => params[:classes][:name])
  		
  	if @class.save!
  		puts 'Its saved'
  		redirect_to :action => 'index'
  	else
  		puts 'not save'
  		render :template => 'classes/index', :locals => { :error => "Please enter a class"}
  	end
  end


  def index
  	@all_classes = Classes.all
  end

end