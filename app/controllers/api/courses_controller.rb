module Api
  class CoursesController < ApplicationController
    respond_to :json

    def index
      respond_with Course.where(school_id: params[:school_id])
    end

  end

end