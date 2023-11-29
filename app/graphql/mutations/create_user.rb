class Mutations::CreateUser < Mutations::BaseMutation
  argument :email, String, required: true
  argument :username, String, required: true
  argument :type, String, required: true
  argument :phone_number, String, required: true
  argument :password, String, required: true

  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(**kwargs)
    user = User.new(kwargs)

    raise GraphQL::ExecutionError, user.errors.full_messages unless user.save

    { user: user }
  end
end
