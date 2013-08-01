class ReportsController < ApplicationController
  def index
    @from_date = params['from'] || format_date(Date.today)
    @to_date = params['to'] || format_date(Date.today)
    @check_ins = CheckIn.where('created_at >= ? AND created_at <= ?', @from_date, @to_date)
  end

  def search
    search_params = params['search']
    redirect_to reports_path(from: search_params['from'], to: search_params['to'])
  end


  def format_date(date)
    date.strftime('%m-%d-%Y')
  end
end
