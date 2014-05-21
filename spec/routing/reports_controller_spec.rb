require 'spec_helper'

describe ReportsController do

  it "should route GET /schools/:school_id/reports to index" do
    expect(:get => "/schools/1/reports").to route_to(:controller => "reports", :action => "index", :school_id => "1")
  end

  it "should route GET /schools/:school_id/report to new" do
    expect(:get => "/schools/1/reports/new").to route_to(:controller => "reports", :action => "new", :school_id => "1")
  end

end
