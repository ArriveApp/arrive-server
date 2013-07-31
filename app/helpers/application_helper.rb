module ApplicationHelper
  def header_button_class_for(page_identifier)
    @_active_page == page_identifier ? 'btn btn-success' : 'btn'
  end

  def active_page_is(active_page)
    @_active_page = active_page
  end

  def todays_date_formatted
    Date.today.strftime('%m-%d-%Y')
  end

end
