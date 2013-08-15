module Api
  class SessionsController < ApiController
    skip_before_filter :authenticate_user!, only: :create

    def create
      user = User.find_for_database_authentication(email: params[:session][:email])
      userName = User.find_by_email(params[:session][:email]).firstname

      if user.present? && user.valid_password?(params[:session][:password])
        user.reset_authentication_token!

        response_body = {user: user,
			 userName: userName,
                         school: user.school,
                         courses: user.school.courses}
        render json: response_body, status: :created
      else
        invalid_login_attempt
      end

    end

    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: {success: false, message: 'Invalid email or password.'}, status: :unauthorized
    end
  end

end
