class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def index
    school_id = params['school_id'].to_i
    @from = params['from'] || format_date(Date.today)
    @to = params['to'] || format_date(Date.today)
    @courses = Course.where(:school_id => school_id)
    @report = params['report'].to_i
    course_id = params['course']

    @check_ins = []
    @students_no_check_in = []

    if @report == 1

      @check_ins = CheckIn.search_by(@from, @to, school_id)
    elsif @report == 2  and course_id!= ""

      students_with_check_in =   CheckIn.search_by_course(@from, @to,school_id,course_id).select(:user_id).distinct
      @students_no_check_in = User.where(is_teacher: false, is_admin:false).where.not(id: students_with_check_in)

    end

  end





  private

  def format_date(date)
    date.strftime('%m-%d-%Y')
  end
end
