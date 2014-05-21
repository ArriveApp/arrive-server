require 'spec_helper'

describe ReportsController do

  let(:school_id) { 1 }
  let(:courses) { [double, double] }
  let(:attrs) { { "from" => '05-20-2014', "to" => '05-22-2014', "type" => 'students_with_checkins', "course_id" => "2" } }
  let(:report) { double("report", :valid? => true, :populate_results => "") }

  before do
    stub_sign_in
    allow(Course).to receive(:where).with({school_id: school_id}) { courses }
  end

  describe '#new' do


    it "assigns courses" do
      get :new, school_id: school_id

      assigns[:courses].should == courses
    end

    it "assigns a new report" do
      allow(Report).to receive(:new).with(school_id) { report }

      get :new, school_id: school_id

      assigns[:report].should == report
    end
  end

  describe '#index' do
    before do
      allow(Report).to receive(:build) { report }
    end

    context "valid report" do
      before { allow(report).to receive(:valid?) { true } }

      it "assigns courses" do
        get :index, report: attrs, school_id: school_id

        assigns[:courses].should == courses
      end

      it "should populate results if the report is valid" do
        expect(report).to receive(:populate_results)

        get :index, report: attrs, school_id: school_id
      end

      it "assigns the report" do
        get :index, report: attrs, school_id: school_id

        assigns[:report].should == report
      end

      it "renders the new template" do
        get :index, report: attrs, school_id: school_id

        response.should render_template(:new)
      end
    end

    context "invalid report" do
      before { allow(report).to receive(:valid?) { false } }

      it "should not populate results" do
        expect(report).to_not receive(:populate_results)

        get :index, report: attrs, school_id: school_id
      end

      it "renders the new template" do
        get :index, report: attrs, school_id: school_id

        response.should render_template(:new)
      end
    end
  end

end
