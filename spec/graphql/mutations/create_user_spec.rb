require 'rails_helper'

RSpec.describe 'mutation create user' do
  it 'create user' do
    result = ClinicSchema.execute(create_query, variables: { email: 'newuser@mail.com',
                                                             username: 'newusername',
                                                             type: 'doctor',
                                                             phoneNumber: '+380505783344',
                                                             password: 'password' })

    expect(result.dig('data', 'createUser', 'user', 'id').present?).to be true
    expect(result.dig('data', 'createUser', 'user', 'email')).to eq('newuser@mail.com')
    expect(result.dig('data', 'createUser', 'user', 'username')).to eq('newusername')
  end

  it 'return error when email not valid' do
    result = ClinicSchema.execute(create_query, variables: { email: 'newuser_mail.com',
                                                             username: 'newusername',
                                                             type: 'doctor',
                                                             phoneNumber: '+380505783344',
                                                             password: 'password' })

    expect(result.dig('data', 'createUser', 'user', 'id').present?).to be false
    expect(result.dig('data', 'createUser')).to eq(nil)
    expect(result['errors'].first['message']).to eq('["Email Invalid email"]')
  end

  it 'return error when params empty' do
    query = <<~GQL
      mutation {
          createUser( input: {
          }) {
            user {
              id
              username
              email
              type
            }
          }
        }
    GQL

    result = ClinicSchema.execute(query)

    expect(result.dig('data', 'createUser', 'user', 'id').present?).to be false
    expect(result.dig('data', 'createUser')).to eq(nil)
    expect(result['errors'].first['message']).to eq("Argument 'email' on InputObject 'CreateUserInput' is required. Expected type String!")
  end

  def create_query
    <<~GQL
      mutation CreateUser($email: String!, $username: String!, $type: String!, $phoneNumber: String!, $password: String!) {
          createUser( input: {
            email: $email,
            username: $username,
            type: $type,
            phoneNumber: $phoneNumber,
            password: $password }
          ) {
            user {
              id
              username
              email
              phoneNumber
              type
            }
          }
        }
    GQL
  end
end
