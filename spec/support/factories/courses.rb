# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence(1) }

    trait :active do
      status { 'active' }
    end
    trait :unactive do
      status { 'unactive' }
    end
    trait :blocked do
      status { 'blocked' }
    end
  end
end
