module Api
  class CheckInsController < ApiController
    def create
      pin = params[:pin]
      user_checking_in_id = current_user.id

      if pin.present?
        user = User.find_by(pin: pin)

        head :unauthorized and return if user.nil?

        user_checking_in_id = user.id
      end

      CheckIn.create(course_id: params[:course_id], user_id: user_checking_in_id, school_id: params[:school_id])

      head :created
    end

  end

end