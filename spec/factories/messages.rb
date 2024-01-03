FactoryBot.define do
  factory :message do
    association :user, factory: %i[user patient_type]
    association :room
    body { 'Test body' }
  end
end
