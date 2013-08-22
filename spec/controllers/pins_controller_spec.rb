require 'spec_helper'

describe PinsController do
  before do
    stub_sign_in
  end

  describe "#new" do
    it "should generate a random unique pin" do
      existing_pins = ["1234", "ABCD", "AB12"]
      school_id = "1"
      User.should_receive(:pins_for_school).with(school_id).and_return(existing_pins)

      get :new, school_id: school_id

      response_hash = JSON.parse(response.body)
      pin = response_hash['pin']
      pin.length.should == User::PIN_LENGTH
      existing_pins.should_not include pin
    end
  end
end
