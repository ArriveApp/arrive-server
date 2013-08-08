require 'spec_helper'

describe CheckIn do

  let(:snape) { FactoryGirl.create(:user, email: "snape@hogwarts.com") }
  let(:dobby) { FactoryGirl.create(:user, email: "dobby@hogwarts.com") }
  let(:magic) { FactoryGirl.create(:course) }

  describe ".search_by" do
    it "should return the checkins made between the provided dates when both from and to are same" do
      today = Time.now.utc
      date = today.strftime('%m-%d-%Y')

      snape_checkin = FactoryGirl.create(:check_in, user: snape, course: magic, created_at: today)
      dobby_checkin = FactoryGirl.create(:check_in, user: dobby, course: magic, created_at: today)

      checkins = CheckIn.search_by date, date

      checkins.should =~ [snape_checkin, dobby_checkin]
    end

    it "should return the checkins made between the provided dates" do
      today = Time.now.utc
      from = today.strftime('%m-%d-%Y')
      to = Time.now.utc.tomorrow.strftime('%m-%d-%Y')

      FactoryGirl.create(:check_in, user: snape, course: magic, created_at: Time.now.utc.yesterday)
      dobby_checkin = FactoryGirl.create(:check_in, user: dobby, course: magic, created_at: today)

      checkins = CheckIn.search_by from, to

      checkins.should =~ [dobby_checkin]
    end
  end
end
