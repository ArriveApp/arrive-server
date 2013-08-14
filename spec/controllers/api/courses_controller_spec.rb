require 'spec_helper'

#TODO: Remove this when removing the controller
describe Api::CoursesController do
  describe '#index' do
    xit 'returns courses for the specified school as json' do
      Course.stub(:where).with(school_id: '1') { [{course: 'course data'}] }

      get :index, school_id: '1', format: :json

      expect(response.body).to eq([{course: 'course data'}].to_json)
    end

  end

end