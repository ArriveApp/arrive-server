FactoryGirl.define do
  factory :check_in do
    school
    course
    after(:build) do |check_in|
      check_in.user = FactoryGirl.build(:user, is_teacher: false, school: check_in.school)
      check_in.course = check_in.course || FactoryGirl.build(:course, school: check_in.school)
    end
  end
end
