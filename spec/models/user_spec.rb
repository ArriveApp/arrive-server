require 'spec_helper'

describe User do

  describe '.pins_for_school' do
    it "should give all the pins for the specific school" do
      school = FactoryGirl.create(:school)
      user1 = FactoryGirl.create(:user, school: school)
      user2 = FactoryGirl.create(:user, school: school)

      pins = User.pins_for_school school.id

      pins.should =~ [user1.pin, user2.pin]
    end

    it "should not get pins from other schools" do
      school1 = FactoryGirl.create(:school)
      school2 = FactoryGirl.create(:school)
      user1 = FactoryGirl.create(:user, school: school1)
      FactoryGirl.create(:user, school: school2)

      pins = User.pins_for_school school1.id

      pins.should =~ [user1.pin]
    end

  end
end
