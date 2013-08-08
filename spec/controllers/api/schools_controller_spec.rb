require 'spec_helper'

describe Api::SchoolsController do
  describe '#index' do
    it 'returns schools as json' do
      School.stub(:all) { [{school: 'school data'}] }

      get :index, format: :json

      expect(response.body).to eq([{school: 'school data'}].to_json)
    end

  end

end