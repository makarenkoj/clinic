module Types
  class PatientProfileType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :description, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, Types::UserType, null: false
    field :appointments, [Types::DoctorsAppointmentType], null: false

    def appointments
      object.doctors_appointments
    end
  end
end
