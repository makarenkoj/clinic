FactoryBot.define do
  factory :doctor_profile do
    association :user, factory: %i[user doctor_type]
    description { 'test' }

    after(:create) do |doctor_profile, _evaluator|
      create(:categories_doctor, doctor_profile: doctor_profile)
    end
  end
end
