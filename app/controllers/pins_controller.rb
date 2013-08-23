class PinsController < ApplicationController
  before_filter :authorized?

  def new
    school_pins = User.pins_for_school(params[:school_id])
    pin_generator = UniquePinGenerator.new(school_pins, User::PIN_LENGTH)

    render json: {pin: pin_generator.next}
  end

end
