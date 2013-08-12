FactoryGirl.define do
  factory :school do
    sequence :name do |n|
      "Hogwarts_#{n}"
    end
  end
end
