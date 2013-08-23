require 'spec_helper'

describe PinsController do
  before do
    stub_sign_in
  end

  describe '#new' do
    let(:school_id) { '1' }

    before do
      User.stub(:pins_for_school)
    end

    it 'returns the next pin from the pin generator' do
      existing_pins = ['1234', '5678']
      User.should_receive(:pins_for_school).with(school_id) { existing_pins }

      pin_generator = double(ArriveServer::UniquePinGenerator)
      pin_generator.stub(:next) { 'abcd' }
      ArriveServer::UniquePinGenerator.should_receive(:new).with(existing_pins, User::PIN_LENGTH) { pin_generator }

      get :new, school_id: school_id

      expect(response.body).to eq({pin: 'abcd'}.to_json)
    end

  end
end
