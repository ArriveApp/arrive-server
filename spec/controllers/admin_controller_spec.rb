require 'spec_helper'

describe AdminController do
  describe '#index' do
    it 'is a success' do
      get :index

      expect(response).to be_success
    end

  end

end