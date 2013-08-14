require 'spec_helper'

#TODO: Remove this when removing the controller
describe Api::SchoolsController do
  describe '#index' do
    xit 'returns schools as json' do
      School.stub(:all) { [{school: 'school data'}] }

      get :index, format: :json

      expect(response.body).to eq([{school: 'school data'}].to_json)
    end

  end

end