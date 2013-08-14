#TODO: Remove this, no longer needed
module Api
  class CoursesController < ApiController
    def index
      render json: Course.where(school_id: params[:school_id])
    end

  end

end