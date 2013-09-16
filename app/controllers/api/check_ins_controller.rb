require 'pry'

module Api
  class CheckInsController < ApiController
    def create
      pin = params[:pin]
      user = current_user


      if pin.present?
        user = User.find_by(pin: pin)

        if user.nil?
        render json: {success: false, error_message: "Invalid PIN" } , status: :unauthorized
        return
        end

      end

      checkIn = CheckIn.where(user_id: user.id, course_id: params[:course_id], school_id: params[:school_id]).last

      if checkIn.nil?  or checkIn.created_at < 45.minutes.ago

        CheckIn.create(course_id: params[:course_id], user_id: user.id, school_id: params[:school_id])
        render json: {firstname: user.firstname}, status: :created

      else

        course = Course.find(params[:course_id])
        render json: {success: false, error_message: "Sorry! You have already checked in " + course.name} , status: :unauthorized


      end

  end
    end

end


