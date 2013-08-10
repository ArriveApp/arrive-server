require 'spec_helper'

describe SchoolsController do
  before do
    stub_sign_in
  end

  describe "GET 'index'" do
    before do
      School.stub(:all) { double(ActiveRecord::Relation).as_null_object }
    end

    it "returns http success" do
      get :index

      expect(response).to be_success
    end
  end

end
