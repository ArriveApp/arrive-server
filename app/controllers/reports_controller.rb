class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def index
    school_id = params['school_id'].to_i
    @from = params['from'] || format_date(Date.today)
    @to = params['to'] || format_date(Date.today)
    @check_ins = CheckIn.search_by(@from, @to, school_id)
  end

  private

  def format_date(date)
    date.strftime('%m-%d-%Y')
  end
end
