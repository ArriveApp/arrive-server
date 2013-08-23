class UniquePinGenerator
  attr_reader :existing_pins, :pin_length

  ALPHA_NUMERICS = [('a'..'z'), ('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten

  def initialize(existing_pins, pin_length)
    @existing_pins = existing_pins
    @pin_length = pin_length
  end

  def next
    random_pin = nil

    begin
      random_pin = random_from(ALPHA_NUMERICS)
    end while existing_pins.include?(random_pin)

    random_pin
  end

  private

  def random_from(scope)
    (0...pin_length).map { scope[Random.rand(scope.length)] }.join
  end

end