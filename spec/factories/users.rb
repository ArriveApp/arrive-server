# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "Griffindor#{n}"
    end
    sequence :email do |n|
      "griffindor_#{n}@hogwarts.com"
    end
    password "pass"
    password_confirmation "pass"
    school
  end
end
