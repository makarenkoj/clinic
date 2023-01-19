FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    username { Faker::Name.first_name }
    phone_number { '+380666666666' }
    password { Faker::Internet.password }
  end
end
