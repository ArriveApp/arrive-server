require 'spec_helper'

describe ReportsController do

  before do
    stub_sign_in
  end

  describe '#index' do
    it "finds check ins using the search params" do
      CheckIn.should_receive(:search_by).with('from', 'to')

      get :index, from: 'from', to: 'to'
    end
  end

  describe '#search' do
    it 'redirects to index with the search params' do
      post :search, search: {from: 'from', to: 'to'}

      expect(response).to redirect_to reports_path(from: 'from', to: 'to')
    end
  end

end
