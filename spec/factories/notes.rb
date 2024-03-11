FactoryBot.define do
  factory :note do
    association :user, factory: %i[user doctor_type]
    date_time { "2024-03-11 22:21:42" }
    body { "MyString" }
  end
end
