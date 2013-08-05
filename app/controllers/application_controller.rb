class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :allow_cross_domain_access

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:user) { |u| u.permit(:name, :username, :school_id, :password, :password_confirmation, :firstname, :lastname) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :username, :school_id, :password, :password_confirmation, :firstname, :lastname) }
  end

  def allow_cross_domain_access
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST"
    response.headers["Access-Control-Allow-Headers"] = "origin, Content-Type, X-Requested-With"
  end
end
