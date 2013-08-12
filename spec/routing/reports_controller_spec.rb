require 'spec_helper'

describe ReportsController do

  it "should route GET /schools/:school_id/reports to index" do
    expect(:get => "/schools/1/reports").to route_to(:controller => "reports", :action => "index", school_id: "1")
  end

end
