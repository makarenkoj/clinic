module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true, description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
                               description: 'An example field added by the generator'
    def test_field
      'Hello World!'
    end

    # /users
    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    # /user
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      user = User.find_by(id: id)

      raise GraphQL::ExecutionError, 'User not found' unless user

      user
    end

    # /categories
    field :categories, [Types::CategoryType], null: false

    def categories
      Category.all
    end

    # /patients
    field :patients, [Types::PatientProfileType], null: false

    def patients
      PatientProfile.all
    end

    # /doctors
    field :doctors, [Types::DoctorProfileType], null: false

    def doctors
      DoctorProfile.all
    end

    # /appointments
    field :appointments, [Types::DoctorsAppointmentType], null: false do
      argument :user_id, ID, required: true
    end

    def appointments(user_id:)
      user = User.find_by(id: user_id)
      raise GraphQL::ExecutionError, 'User not found' unless user

      user.doctor? ? user.doctor_profile.doctors_appointments : user.patient_profile.doctors_appointments
    end
  end
end
