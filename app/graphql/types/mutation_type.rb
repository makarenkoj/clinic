module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    #     field :login, Types::UserType, null: false do
    #       argument :email, String, required: true
    #       argument :password, String, required: true
    #     end
    #     def login(email:, password:)
    #       user = User.find_by(email: email)
    # binding.b
    #       if user&.authenticate(password)
    #         user
    #       else
    #         raise GraphQL::ExecutionError.new(I18n.t('devise.failure.invalid'))
    #       end
    #     end
  end
end
