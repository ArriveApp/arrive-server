module ApplicationHelper
  def render_header_for(selected_button)
    render partial: 'common/header', locals: {selected_button: selected_button}
  end

  def header_button_class(selected_button, this_button)
    selected_button == this_button ? 'btn btn-success' : 'btn'
  end
end
