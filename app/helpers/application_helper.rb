module ApplicationHelper
  def nav_class_for(page_identifier)
    @_active_page == page_identifier ? 'active' : ''
  end

  def active_page_is(active_page)
    @_active_page = active_page
  end

  def error_messages(object)
    object.errors.full_messages.flatten
  end

  def format_timestamp(timestamp)
    DateTime.parse(timestamp).strftime('%b, %d, %Y %I:%M %p %Z')
  end

end
