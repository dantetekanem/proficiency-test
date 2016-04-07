# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    register_number { SecureRandom.hex(8) }

    trait :active do
      status { 'active' }
    end
    trait :unactive do
      status { 'unactive' }
    end
  end
end
