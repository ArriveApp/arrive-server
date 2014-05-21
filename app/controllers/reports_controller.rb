class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def index
    school_id = params['school_id'].to_i
    @report = Report.build params['report'], school_id
    @courses = Course.where(:school_id => school_id)
    if @report.valid?
      @report.populate_results
      render :new
    else
      render :new
    end
  end

  def new
    school_id = params['school_id'].to_i
    @courses = Course.where(:school_id => school_id)
    @report = Report.new school_id
  end

end
