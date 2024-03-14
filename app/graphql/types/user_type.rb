module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :encrypted_password, String, null: false
    field :phone_number, String, null: false
    field :username, String, null: false
    field :type, String, null: false
    field :reset_password_token, String
    field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime
    field :remember_created_at, GraphQL::Types::ISO8601DateTime
    field :appointments_count, Integer, null: false

    def appointments_count
      object.doctor_profile ? object.doctor_profile.doctors_appointments.count : object.patient_profile.doctors_appointments.count
    end
  end
end
