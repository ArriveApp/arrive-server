# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "Dumbledore"
    email "dd@hogwarts.com"
    password "password"
    password_confirmation "password"
    school
  end
end
