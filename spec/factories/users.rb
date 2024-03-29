FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    username { "#{FFaker::Name.first_name}#{rand(100)}" }
    phone_number { '+380666666666' }
    password { Faker::Internet.password }

    trait :doctor_type do
      type { User::DOCTOR }
      after(:create) do |user, _evaluator|
        create(:categories_doctor, doctor_profile: user.doctor_profile)
      end
    end

    trait :patient_type do
      type { User::PATIENT }
    end
  end
end
