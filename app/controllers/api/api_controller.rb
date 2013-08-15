module Api
  class ApiController < ActionController::Base
    protect_from_forgery

    before_filter :allow_cross_domain_access, :authenticate_user!
    skip_before_filter :authenticate_user!, only: :options

    respond_to :json

    def options
      head :ok
    end


    def allow_cross_domain_access
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Request-Method'] = '*'
      response.headers["Access-Control-Allow-Methods"] = "PUT, OPTIONS, GET, DELETE, POST"
      response.headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type'
    end

    def authenticate_user!
      if current_user.nil?
        warden.custom_failure!
        head :unauthorized
      end
    end

  end

end