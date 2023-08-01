FactoryBot.define do
  factory :dictionary do
    association :user, factory: %i[user patient_type]
    name { FFaker::Name.first_name }
    language { 'english' }
  end
end
