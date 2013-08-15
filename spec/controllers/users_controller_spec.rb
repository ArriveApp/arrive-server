require 'spec_helper'

describe UsersController do

  before do
    stub_sign_in
    @school = FactoryGirl.create(:school)
  end
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index', school_id: @school.id

      expect(response).to be_succes
    end
  end
  
  describe "POST create" do
    it "should create a new user" do
      post 'create', user: {firstname: 'chris', lastname: 'george', email: 'email@email.com', password: '1234'}, school_id: @school.id
      
      expect(User.count).to be 1
      flash[:notice].should == 'User was created successfully.'
    end

    it "should set the password as the pin when creating a user" do
      User.should_receive(:new).with(hash_including(pin: '1234')) { double(User).as_null_object }

      post 'create', user: {firstname: 'chris', lastname: 'george', email: 'email@email.com', password: '1234'}, school_id: @school.id
    end
    
    it "should not create an invalid user" do
      post 'create', user: {}, school_id: @school.id
      
      expect(User.count).to be 0
      flash[:alert].should == "Failed to create user"
    end
  end
  
  describe "POST bulk_add" do
    it "adds users from a csv file" do
      file = fixture_file_upload('users.csv', 'text/csv')
      post 'bulk_add', file: file, school_id: @school.id
      
      expect(User.count).to be 2
      expect(User.first.school).to eql @school
      flash[:notice].should == '2 users created'
    end
    
    it "displays error on invalid csv file" do
      file = fixture_file_upload('invalid.csv', 'text/csv')
      post 'bulk_add', file: file, school_id: @school.id
      
      flash[:alert].should == 'Invalid CSV file uploaded'
    end

    it "should set the password as the pin when creating a user" do
      file = fixture_file_upload('users.csv', 'text/csv')

      post 'bulk_add', file: file, school_id: @school.id
      User.all.map(&:pin).should =~ ['1234', '4321']
    end
  end
end
