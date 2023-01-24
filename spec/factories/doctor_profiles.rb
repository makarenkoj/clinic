FactoryBot.define do
  factory :doctor_profile do
    association :user, factory: %i[doctor_type]
    description { 'test' }
  end
end
