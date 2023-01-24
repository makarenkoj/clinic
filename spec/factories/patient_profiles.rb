FactoryBot.define do
  factory :patient_profile do
    association :user, factory: %i[patient_type]
    description { 'test' }
  end
end
