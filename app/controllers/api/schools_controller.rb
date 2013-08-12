module Api
  class SchoolsController < ApiController
    def index
      render json: School.all
    end

  end

end