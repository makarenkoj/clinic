FactoryBot.define do
  factory :category do
    name_ua { FFaker::Name.first_name }
    name_en { FFaker::Name.first_name }
  end
end
