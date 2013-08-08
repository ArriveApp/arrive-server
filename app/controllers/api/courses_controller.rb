module Api
  class CoursesController < ApplicationController
    respond_to :json

    def index
      respond_with Course.find_by(school_id: params[:school_id])
    end

  end

end