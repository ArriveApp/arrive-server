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

      time = Time.now   -  45*60

      checkIn = CheckIn.where("course_id = :course_id AND user_id = :user_id AND school_id = :school_id AND created_at >= :time",
                              {course_id: params[:course_id], user_id: user.id, school_id: params[:school_id], time: time})

      if checkIn.count == 0
        CheckIn.create(course_id: params[:course_id], user_id: user.id, school_id: params[:school_id])
        render json: {success: true,firstname: user.firstname}, status: :created
      else
        course_id = params[:course_id]
        courseToCheckIn = Course.find(course_id)
        render json: {success: false, error_message: "Sorry! You have already checked in to " + courseToCheckIn.name } , status: :unauthorized

      end

  end


  end

end