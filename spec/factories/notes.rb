FactoryBot.define do
  factory :note do
    association :user, factory: %i[user doctor_type]
    date_time { Time.now }
    body { Faker::Quote.matz }
  end
end
