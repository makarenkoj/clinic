require 'rails_helper'

RSpec.describe 'query appointments' do
  it 'get appointments informations' do
    user_patient = create(:user, :patient_type)
    create_list(:doctors_appointment, 5, patient_profile: user_patient.patient_profile)

    query = <<~GQL
      query {
          appointments (userId: "#{user_patient.id}") {
            id
            visitTime
            description
            doctor {
              id
              description
              user {
                id
                email
              }
            }
            patient {
              id
              description
              user {
                id
                email
              }
            }
          }
        }
    GQL

    result = ClinicSchema.execute(query)

    expect(result.dig('data', 'appointments').size).to eq(5)
    expect(result.dig('data', 'appointments').first.dig('patient', 'user', 'email')).to eq(user_patient.email)
    expect(result.dig('data', 'appointments').first['doctor'].present?).to be true
  end

  it 'get appointments informations' do
    user_patient = create(:user, :patient_type)

    query = <<~GQL
      query {
          appointments (userId: "#{user_patient.id}") {
            id
            visitTime
            description
            doctor {
              id
              description
              user {
                id
                email
              }
            }
            patient {
              id
              description
              user {
                id
                email
              }
            }
          }
        }
    GQL

    result = ClinicSchema.execute(query)

    expect(result.dig('data', 'appointments').size).to eq(0)
    expect(result.dig('data', 'appointments')).to eq([])
  end

  it 'get user not found' do
    query = <<~GQL
      query {
          appointments (userId: 11111) {
            id
            visitTime
            description
            doctor {
              id
              description
              user {
                id
                email
              }
            }
            patient {
              id
              description
              user {
                id
                email
              }
            }
          }
        }
    GQL

    result = ClinicSchema.execute(query)

    expect(result['errors'].first['message']).to eq('User not found')
  end
end
