require 'rails_helper'

RSpec.describe 'query patients' do
  it 'return patients information' do
    create_list(:user, 5, :patient_type)
    create(:doctors_appointment, patient_profile: PatientProfile.first)

    query = <<~GQL
      query {
        patients {
            id
            user {
              username
            }
            appointments {
                id
                visitTime
              }
          }
        }
    GQL

    result = ClinicSchema.execute(query)

    expect(result.dig('data', 'patients').size).to eq(5)
    expect(result.dig('data', 'patients').first['user']['username'].present?).to be true
    expect(result.dig('data', 'patients').first['appointments'].first['visitTime'].present?).to be true
  end

  it 'when didnt have patient' do
    query = <<~GQL
      query {
        patients {
            id
            user {
              username
            }
            appointments {
              id
            }
          }
        }
    GQL

    result = ClinicSchema.execute(query)

    expect(result.dig('data', 'patients')).to eq([])
  end
end
