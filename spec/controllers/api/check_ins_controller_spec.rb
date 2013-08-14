require 'spec_helper'

describe Api::CheckInsController do
  describe '#create' do
    def post_to_create(check_in_params = {})
      params = {format: :json, auth_token: 'some auth token', school_id: school_id, course_id: course_id}
      post :create, params.merge(check_in_params)
    end

    let(:check_in) { double(CheckIn).as_null_object }
    let(:course_id) { '2' }
    let(:user_id) { '3' }
    let(:school_id) { '1' }

    before do
      stub_sign_in
      CheckIn.stub(:create) { check_in }
    end

    let(:user) { double(User, id: user_id) }

    context 'check in with no pin' do
      it 'creates a check in for the current user' do
        controller.stub(:current_user) { user }

        CheckIn.should_receive(:create).with(course_id: course_id, user_id: user_id, school_id: school_id)

        post_to_create
      end
    end

    context 'check in with a pin' do
      xit 'creates a check in for the user with the specified pin' do
        User.should_receive(:find).with(pin: '1234') { user }

        CheckIn.should_receive(:create).with(course_id: course_id, user_id: user_id)

        post_to_create(pin: '1234')
      end
    end

    it 'returns a 201' do
      post_to_create

      expect(response.status).to eq(201)
    end

    it 'renders the check in as json' do
      check_in.stub(:to_json) { {check_in: 'details'}.to_json }

      post_to_create

      expect(response.body).to eq({check_in: 'details'}.to_json)
    end

  end

end