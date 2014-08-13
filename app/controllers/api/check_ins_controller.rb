require 'pry'

module Api
  class CheckInsController < ApiController

    @@time_interval_for_different_courses = 30;
    @@time_interval_for_same_course = 12;

    def create
      pin = params[:pin]
      user = current_user


      if pin.present?
        user = User.find_by(pin: pin, :is_deleted => false)

        if user.nil?
          render json: {success: false, error_message: "Invalid PIN"}, status: :unauthorized
          return
        end

      end

      p user.to_s
      p params[:school_id]
      checkIn = CheckIn.where(user_id: user.id, school_id: params[:school_id]).last
      p checkIn
      unless checkIn.nil?

        if (checkIn.course_id == params[:course_id].to_i) and (not respects_time_interval_for_same_course checkIn)
          course = Course.find(params[:course_id])
          render json: {success: false, error_message: "Sorry! You have already checked in " + course.name + ". Please, try checking in again in a few hours."}, status: :unauthorized
          return
        end

        unless respects_time_interval_for_different_courses checkIn
          minutes_to_wait = minutes_to_wait_until_next_checkin checkIn.created_at
          render json: {success: false, error_message: "Sorry! You have to wait " + minutes_to_wait.to_s + " minutes until you can check in to your next class."}, status: :unauthorized
          return
        end

      end

      CheckIn.create(course_id: params[:course_id], user_id: user.id, school_id: params[:school_id])
      render json: {firstname: user.firstname}, status: :created

    end

    def respects_time_interval_for_same_course(checkIn)
      checkIn.created_at < @@time_interval_for_same_course.hours.ago
    end

    def minutes_to_wait_until_next_checkin(checkin_time)
      @@time_interval_for_different_courses - ((Time.now - checkin_time) / 1.minute).ceil
    end


    def respects_time_interval_for_different_courses(checkIn)
      checkIn.created_at < @@time_interval_for_different_courses.minutes.ago
    end

  end

end


