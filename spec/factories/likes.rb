FactoryBot.define do
  factory :like do
    association :user, factory: %i[user patient_type]
    association :message
  end
end
