require 'spec_helper'

describe User do
  describe '.pins_for_school' do
    it "returns all the pins for the specific school" do
      FactoryGirl.create(:user, pin: '1234', school_id: '1')
      FactoryGirl.create(:user, pin: '5678', school_id: '1')

      FactoryGirl.create(:user, pin: 'abcd', school_id: '2')

      pins = User.pins_for_school('1')

      expect(pins).to eq(['1234', '5678'])
    end
  end


end
