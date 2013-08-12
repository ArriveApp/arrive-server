module Api
  class ApiController < ActionController::Base
    protect_from_forgery
    before_filter :allow_cross_domain_access

    respond_to :json

    def allow_cross_domain_access
      response.headers["Access-Control-Allow-Origin"] = "*"
      response.headers["Access-Control-Allow-Methods"] = "GET, POST"
      response.headers["Access-Control-Allow-Headers"] = "origin, Content-Type, X-Requested-With"
    end

  end

end