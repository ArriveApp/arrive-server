require 'spec_helper'

describe SchoolsController do
  before do
    stub_sign_in
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
