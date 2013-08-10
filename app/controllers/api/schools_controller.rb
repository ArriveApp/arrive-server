module Api
  class SchoolsController < ApiController
    def index
      respond_with School.all
    end

  end

end