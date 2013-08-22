class PinsController < ApplicationController
  before_filter :authorized?

  def new
    pins = User.pins_for_school(params[:school_id])
    random_pin = generate_unique_pin pins
    render json: {pin: random_pin}
  end

  private 

  def random_alpha_numeric scope
    (0...User::PIN_LENGTH).map { scope[Random.rand(scope.length)] }.join
  end

  def generate_unique_pin pins
    alpha_numerics = [('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
    random_pin = random_alpha_numeric(alpha_numerics)
    until !pins.include? random_pin do
      random_pin = random_alpha_numeric
    end
    random_pin
  end
end
