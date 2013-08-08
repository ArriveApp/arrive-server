require 'spec_helper'

describe Api::CoursesController do
  describe '#index' do
    it 'returns courses for the specified school as json' do
      Course.stub(:find_by).with(school_id: '1') { [{course: 'course data'}] }

      get :index, school_id: '1', format: :json

      expect(response.body).to eq([{course: 'course data'}].to_json)
    end

  end

end