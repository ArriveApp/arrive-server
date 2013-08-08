require 'spec_helper'

describe CoursesController do
  let(:school_id) { '1' }
  let(:school) { double(School, id: school_id) }
  let(:courses) { [] }

  before do
    stub_sign_in

    School.stub(:find) { school }
    school.stub(:courses) { courses }
  end

  describe '#index' do
    before do
      Course.stub(:new)
    end

    it 'is a success' do
      get :index, school_id: school_id

      expect(response).to be_success
    end

  end

  describe '#create' do
    let(:course) { double(Course, name: 'Class double').as_null_object }

    before do
      Course.stub(:new) { course }
    end

    it 'redirects to index when successful' do
      course.stub(:save) { true }

      post :create, school_id: school_id, course: {name: 'Math'}

      expect(response).to redirect_to school_courses_path(school_id: school_id)
    end

    it 'renders the index when unsuccessful' do
      course.stub(:save) { false }

      post :create, school_id: school_id, course: {name: ''}

      expect(response).to render_template :index
    end

    it 'creates the course with the current users school' do
      Course.should_receive(:new).with(name: 'Math', school_id: school_id)

      post :create, school_id: school_id, course: {name: 'Math'}
    end

  end

end
