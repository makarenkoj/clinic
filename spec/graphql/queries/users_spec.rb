require 'rails_helper'

RSpec.describe 'query users' do
  it 'return information about all users' do
    create_list(:user, 5, :patient_type)

    query = <<~GQL
      query {
            users {
              id
              username
              email
              phoneNumber
              type
            }
        }
    GQL

    result = ClinicSchema.execute(query)

    expect(result.dig('data', 'users').size).to eq(5)
    expect(result.dig('data', 'users').first['type']).to eq('patient')
  end

  it 'return nill if dont have users' do
    query = <<~GQL
      query {
            users {
              id
              username
              email
              phoneNumber
              type
            }
        }
    GQL

    result = ClinicSchema.execute(query)

    expect(result.dig('data', 'users').size).to eq(0)
    expect(result.dig('data', 'users')).to eq([])
  end
end
