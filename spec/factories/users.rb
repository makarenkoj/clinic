FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    username { Faker::Internet.username(specifier: 4..10) }
    phone_number { '+380666666666' }
    password { Faker::Internet.password }

    trait :doctor_type do
      type { User::DOCTOR }
    end

    trait :patient_type do
      type { User::PATIENT }
    end
  end
end
