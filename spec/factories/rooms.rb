FactoryBot.define do
  factory :room do
    association :user, factory: %i[user patient_type]
  end
end
