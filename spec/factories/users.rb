# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "Dumbledore"
    email "dd@hogwarts.com"
    password "pass"
    password_confirmation "pass"
    school
  end
end
