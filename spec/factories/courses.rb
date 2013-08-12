FactoryGirl.define do
  factory :course do
    sequence :name do |n|
      "Math_#{n}"
    end
    school
  end
end
