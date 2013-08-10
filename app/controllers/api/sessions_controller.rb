module Api
  class SessionsController < ApiController

    skip_before_action :verify_authenticity_token
    before_filter :ensure_params_exist

    def create
      resource = User.find_for_database_authentication(email: params[:user][:email])
      return invalid_login_attempt unless resource

      if resource.valid_password?(params[:user][:password])
        resource.reset_authentication_token!
        render json: {success: true, auth_token: resource.authentication_token, email: resource.email}
        return
      end
      invalid_login_attempt
    end

    protected

    def ensure_params_exist
      return unless params[:user].blank?
      render json: {success: false, message: 'Missing user credentials.'}, status: 422
    end

    def invalid_login_attempt
      warden.custom_failure!
      render json: {success: false, message: 'Invalid email or password.'}, status: 401
    end
  end

end
