require 'rails_helper'

RSpec.describe 'query user' do
  it 'return information about all user' do
    user = create(:user, :patient_type)

    query = <<~GQL
      query {
            user(id: "#{user.id}") {
                id
                username
                email
                appointmentsCount
                type 
            }
        }
    GQL

    result = ClinicSchema.execute(query)

    expect(result.dig('data', 'user', 'id')).to eq(String(user.id))
    expect(result.dig('data', 'user', 'email')).to eq(user.email)
  end

  it 'return information when brocken id' do
    create(:user, :patient_type)

    query = <<~GQL
      query {
            user(id: 999999) {
                id
                username
                email
                appointmentsCount
                type 
            }
        }
    GQL

    result = ClinicSchema.execute(query)

    expect(result['errors'].first['message']).to eq('User not found')
  end
end
