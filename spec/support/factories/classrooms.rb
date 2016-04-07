# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classroom do
    student
    course
    entry_at { Faker::Date.between(2.days.ago, Date.today) }
  end
end
