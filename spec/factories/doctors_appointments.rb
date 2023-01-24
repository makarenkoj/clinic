FactoryBot.define do
  factory :doctors_appointment do
    association :doctor_profile, factory: :doctor_profile
    association :patient_profile, factory: :patient_profile
    visit_time { Time.current }
  end
end
