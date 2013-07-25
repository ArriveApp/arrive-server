require 'spec_helper'

describe ClassesController do
  describe '#index' do
    before do
      stub_sign_in
    end

    it 'is a success' do
      get :index

      expect(response).to be_success
    end

  end

end