require 'spec_helper'

describe CoursesController do
  before do
    stub_sign_in
  end

  describe '#index' do
    it 'is a success' do
      get :index

      expect(response).to be_success
    end

  end

  describe '#create' do
    before do
      Course.stub(:new) { stub_class }
    end

    let(:stub_class) { double(Course, name: 'Class double') }

    it 'redirects to index when successful' do
      stub_class.stub(:save) { true }

      post :create, course: {name: 'Math'}

      expect(response).to redirect_to courses_path
    end

    it 'renders the index when unsuccessful' do
      stub_class.stub(:save) { false }

      post :create, course: {name: ''}

      expect(response).to render_template :index
    end

  end

end
