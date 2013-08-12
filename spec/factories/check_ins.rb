FactoryGirl.define do
  factory :check_in do
    school
    after(:build) do |check_in|
      check_in.user = FactoryGirl.build(:user, school: check_in.school)
      check_in.course = FactoryGirl.build(:course, school: check_in.school)
    end
  end
end
