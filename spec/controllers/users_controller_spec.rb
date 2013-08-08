require 'spec_helper'

describe UsersController do


  describe "GET 'new'" do
    before do
      stub_sign_in

      School.stub(:find){ double(School).as_null_object }
      User.stub(:new)
    end

    it "returns http success" do
      get 'new', school_id: '1'

      expect(response).to be_succes
    end
  end

end
