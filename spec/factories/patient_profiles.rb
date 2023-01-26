FactoryBot.define do
  factory :patient_profile do
    association :user, factory: %i[user patient_type]
    description { 'test' }
  end
end
