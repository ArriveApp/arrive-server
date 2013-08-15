module Api
  class CheckInsController < ApiController
    def create
      pin = params[:pin]
      user = current_user

      if pin.present?
        user = User.find_by(pin: pin)

        head :unauthorized and return if user.nil?
      end

      CheckIn.create(course_id: params[:course_id], user_id: user.id, school_id: params[:school_id])

      render json: {firstname: user.firstname}, status: :created
    end

  end

end