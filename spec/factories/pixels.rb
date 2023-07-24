FactoryBot.define do
  factory :pixel do
    association :user, factory: %i[user patient_type]
    x { 1 }
    y { 1 }
    color { FFaker::Color.name }
  end
end
