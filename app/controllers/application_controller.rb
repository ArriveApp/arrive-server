class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_credentials
  before_filter :set_cache_buster

  protected

  def authorized?
    check_for_user
    check_credentials
  end

  def check_for_user
    redirect_to new_user_session_path unless current_user
  end

  def check_credentials
    if current_user && !current_user.is_teacher?
      sign_out(current_user)
      redirect_to root_path
    end
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"

  end

end
