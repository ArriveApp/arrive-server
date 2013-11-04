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
    let(:another_course_id) { '4' }

    let(:user) { User.new(id: user_id) }
    let(:course_to_check_in) { Course.new(id: course_id, name: "Course name") }


    before do
      stub_sign_in

      CheckIn.stub(:create)
      User.stub(:find) { user }
    end

    context 'check in with no pin' do

      it 'creates a check in for the current user' do
        controller.stub(:current_user) { user }

        CheckIn.should_receive(:where).and_return([])
        CheckIn.should_receive(:create).with(course_id: course_id, user_id: user_id, school_id: school_id)


        post_to_create
      end
    end

    context 'student has checked in another course in the last 30 minutes' do
      let(:old_check_in) {
        CheckIn.new(course_id: another_course_id, user_id: user_id, school_id: school_id, created_at: 29.minutes.ago)
      }

      before :each do
        CheckIn.should_receive(:where).and_return([old_check_in])
      end

      it 'its unauthorized' do
        post_to_create
        expect(response.status).to eq(401)
      end

    end

    context 'student has checked in the last 12 hours' do
      let(:old_check_in) {
        CheckIn.new(course_id: course_id, user_id: user_id, school_id: school_id, created_at: 11.hours.ago)
      }

      before :each do
        CheckIn.should_receive(:where).and_return([old_check_in])
        Course.should_receive(:find).and_return(course_to_check_in)
      end

      it 'its unauthorized' do
        post_to_create
        expect(response.status).to eq(401)
      end

    end

    context 'check in with a pin' do
      let(:pin) { '1234' }
      let(:user_with_pin_id) { 4 }
      let(:user_with_pin) { User.new(id: user_with_pin_id) }

      it 'creates a check in for the user with the specified pin' do
        User.should_receive(:find_by).with(pin: pin, is_deleted: false) { user_with_pin }

        CheckIn.should_receive(:where).and_return([])
        CheckIn.should_receive(:create).with(course_id: course_id, user_id: user_with_pin_id, school_id: school_id)

        post_to_create(pin: pin)
      end

      it 'is unauthorized and does not create a check in if the pin is not valid' do
        User.should_receive(:find_by).with(pin: pin, is_deleted: false) { nil }
        CheckIn.should_not_receive(:create)

        post_to_create(pin: pin)

        expect(response.status).to eq(401)
      end


      it 'returns a 201' do
        user.stub(:firstname) { 'Ned Stark' }
        controller.stub(:current_user) { user }

        post_to_create

        expect(response.status).to eq(201)
        expect(response.body).to eq({firstname: 'Ned Stark'}.to_json)
      end


      context 'student has checked in in the last 45 minutes' do
        let(:old_check_in) {
          CheckIn.new(course_id: course_id, user_id: user_with_pin_id, school_id: school_id, created_at: 40.minutes.ago)
        }

        before :each do
          CheckIn.should_receive(:where).and_return([old_check_in])
          Course.should_receive(:find).and_return(course_to_check_in)
        end

        it 'its unauthorized' do
          post_to_create
          expect(response.status).to eq(401)
        end

      end


    end


  end

end
