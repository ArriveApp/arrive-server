require 'spec_helper'

describe CheckIn do

  let(:hogwarts) { FactoryGirl.create(:school) }
  let(:winterfell) { FactoryGirl.create(:school, name: "winterfell") }

  describe "validations" do
    it "should validate for the presence of user, course and school" do
      presence_validators = CheckIn.validators.select{|v| v.kind_of? ActiveRecord::Validations::PresenceValidator}
      presence_validators.map(&:attributes).flatten.should =~ [:user, :course, :school]
    end
  end

  describe ".search_by" do
    it "should return the checkins made between the provided dates when both from and to are same" do
      today = Time.now.utc
      date = today.strftime('%m-%d-%Y')

      snape_checkin = FactoryGirl.create(:check_in, school: hogwarts, created_at: today)
      dobby_checkin = FactoryGirl.create(:check_in, school: hogwarts, created_at: today)

      checkins = CheckIn.search_by date, date, hogwarts.id

      checkins.should =~ [snape_checkin, dobby_checkin]
    end

    it "should return the checkins made between the provided dates" do
      today = Time.now.utc
      from = today.strftime('%m-%d-%Y')
      to = Time.now.utc.tomorrow.strftime('%m-%d-%Y')

      FactoryGirl.create(:check_in, school: hogwarts, created_at: Time.now.utc.yesterday)
      dobby_checkin = FactoryGirl.create(:check_in, school: hogwarts, created_at: today)

      checkins = CheckIn.search_by from, to, hogwarts.id

      checkins.should =~ [dobby_checkin]
    end

    it "should not retun the checkins of a different school" do
      today = Time.now.utc
      date = today.strftime('%m-%d-%Y')

      FactoryGirl.create(:check_in, school: winterfell, created_at: today)
      snape_checkin = FactoryGirl.create(:check_in, school: hogwarts, created_at: today)
      dobby_checkin = FactoryGirl.create(:check_in, school: hogwarts, created_at: today)

      checkins = CheckIn.search_by date, date, hogwarts.id

      checkins.should =~ [snape_checkin, dobby_checkin]
    end
  end
end
