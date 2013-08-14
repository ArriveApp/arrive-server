require 'spec_helper'

describe Api::CheckInsController do
  describe '#create' do
    def post_to_create
      post :create, format: :json, auth_token: 'some auth token', school_id: '1', course_id: course_id, check_in: {user_id: user_id}
    end

    let(:check_in) { double(CheckIn).as_null_object }
    let(:course_id) { '2' }
    let(:user_id) { '3' }

    before do
      stub_sign_in
      CheckIn.stub(:create) { check_in }
    end

    it 'returns a 201' do
      post_to_create

      expect(response.status).to eq(201)
    end

    it 'creates a check in' do
      CheckIn.should_receive(:create).with(course_id: course_id, user_id: user_id)

      post_to_create
    end

    it 'renders the check in as json' do
      check_in.stub(:to_json) { {check_in: 'details'}.to_json }

      post_to_create

      expect(response.body).to eq({check_in: 'details'}.to_json)
    end

  end

end