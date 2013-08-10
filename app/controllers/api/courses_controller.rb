module Api
  class CoursesController < ApiController
    def index
      respond_with Course.where(school_id: params[:school_id])
    end

  end

end