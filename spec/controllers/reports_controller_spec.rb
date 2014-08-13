require 'spec_helper'

describe ReportsController do

  before do
    stub_sign_in
    @school = FactoryGirl.create(:school)
    @course = FactoryGirl.create(:course)
  end

  describe 'report of check ins' do 

    it "finds check ins using the search params in the request" do
      CheckIn.should_receive(:search_by).with('from', 'to', 1)

      get :index, from: 'from', to: 'to', school_id: 1, report: 1
    end

    it "finds check ins using todays dates if no search params exist" do
      todays_date = Date.today
      formatted_date = todays_date.strftime('%m-%d-%Y')
      Date.stub(:today => todays_date)
      CheckIn.should_receive(:search_by).with(formatted_date, formatted_date, 1)

      get :index, school_id: 1 , report:1
    end
  end 

    describe 'specify test students' do 

      it "assigns students with checkins" do
        todays_date = Date.today
        formatted_date = todays_date.strftime('%m-%d-%Y')
        course = FactoryGirl.create(:course, name: "Tiger Academy", school: @school)
        student1 = FactoryGirl.create(:user, is_teacher: false, is_admin: false, school: @school, firstname: "clark")
        student2 = FactoryGirl.create(:user, is_teacher: false, is_admin: false, school: @school, firstname: "bruce")
        check_in = CheckIn.create(user: student1, school: @school, course: course, created_at: todays_date)

        get :index, school_id: 1 , report: 2, course: course.id
        assigns(:students_no_check_in).should == [student2]
      end 
    end

  describe 'report of students without check ins' do
    
    it "finds students without check ins using the search params in the request" do
      CheckIn.should_receive(:search_by_course).with('from', 'to', 1, 1)

      get :index, from: 'from', to: 'to', school_id: 1, report: 2, course: 1
    end
  end 

end
