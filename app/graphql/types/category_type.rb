module Types
  class CategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name_ua, String, null: false
    field :name_en, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :doctors, [Types::DoctorProfileType], null: false

    def doctors
      object.doctor_profiles
    end
  end
end
