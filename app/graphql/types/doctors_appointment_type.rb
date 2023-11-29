module Types
  class DoctorsAppointmentType < Types::BaseObject
    field :id, ID, null: false
    field :doctor_profile_id, Integer, null: false
    field :patient_profile_id, Integer, null: false
    field :visit_time, GraphQL::Types::ISO8601DateTime
    field :description, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :doctor, [Types::DoctorProfileType], null: false
    field :patient, [Types::PatientProfileType], null: false
  end
end
