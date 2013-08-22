# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "griffindor_#{n}@hogwarts.com"
    end
    password "pass"
    password_confirmation "pass"
    firstname "harry"
    lastname "potter"
    sequence :pin do |n|
      sprintf("%04d", n)
    end
    school
  end
end
