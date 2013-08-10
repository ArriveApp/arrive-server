module Api
  class CheckInsController < ApiController
    def create
      check_in_params = params[:check_in]

      check_in = CheckIn.create(course_id: params[:course_id], user_id: check_in_params[:user_id])

      render json: check_in, status: :created
    end

  end

end