FactoryBot.define do
  factory :place do
    association :doctor_profile
    name { 'London' }
    location { 'London' }
  end
end
