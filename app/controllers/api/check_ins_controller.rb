module Api
  class CheckInsController < ApiController
    def create
      check_in = CheckIn.create(course_id: params[:course_id], user_id: current_user.id, school_id: params[:school_id])

      render json: check_in, status: :created
    end

  end

end