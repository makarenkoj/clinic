FactoryBot.define do
  factory :categories_doctor do
    association :doctor_profile
    association :category
  end
end
