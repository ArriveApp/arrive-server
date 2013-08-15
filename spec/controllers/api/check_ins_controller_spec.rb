require 'spec_helper'

describe Api::CheckInsController do
  describe '#create' do
    def post_to_create(check_in_params = {})
      params = {format: :json, auth_token: 'some auth token', school_id: school_id, course_id: course_id}
      post :create, params.merge(check_in_params)
    end

    let(:school_id) { '1' }
    let(:course_id) { '2' }
    let(:user_id) { 3 }

    let(:user) { User.new(id: user_id) }

    before do
      stub_sign_in

      CheckIn.stub(:create)
      User.stub(:find) { user }
    end

    context 'check in with no pin' do
      it 'creates a check in for the current user' do
        controller.stub(:current_user) { user }

        CheckIn.should_receive(:create).with(course_id: course_id, user_id: user_id, school_id: school_id)

        post_to_create
      end
    end

    context 'check in with a pin' do
      let(:pin) { '1234' }
      let(:user_with_pin_id) { 4 }
      let(:user_with_pin) { User.new(id: user_with_pin_id) }

      it 'creates a check in for the user with the specified pin' do
        User.should_receive(:find_by).with(pin: pin) { user_with_pin }

        CheckIn.should_receive(:create).with(course_id: course_id, user_id: user_with_pin_id, school_id: school_id)

        post_to_create(pin: pin)
      end

      it 'is unauthorized and does not create a check in if the pin is not valid' do
        User.should_receive(:find_by).with(pin: pin) { nil }
        CheckIn.should_not_receive(:create)

        post_to_create(pin: pin)

        expect(response.status).to eq(401)
      end
    end

    it 'returns a 201' do
      user.stub(:firstname) { 'Ned Stark' }
      controller.stub(:current_user) { user }

      post_to_create

      expect(response.status).to eq(201)
      expect(response.body).to eq({firstname: 'Ned Stark'}.to_json)
    end

  end

end