require 'rails_helper'

RSpec.describe 'query doctors' do
  it 'return doctors information' do
    create_list(:user, 5, :doctor_type)
    create(:doctors_appointment, doctor_profile: DoctorProfile.first)
  
    query = <<~GQL
      query {
        doctors {
            id
            description
            categories {
              nameUa
            }
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

    expect(result.dig('data', 'doctors').size).to eq(5)
    expect(result.dig('data', 'doctors').first['user']['username'].present?).to be true
    expect(result.dig('data', 'doctors').first['categories'].present?).to be true
    expect(result.dig('data', 'doctors').first['appointments'].first['visitTime'].present?).to be true
  end

  it 'return doctors information' do
    query = <<~GQL
      query {
        doctors {
            id
            description
            categories {
              nameUa
            }
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

    expect(result.dig('data', 'doctors').size).to eq(0)
    expect(result.dig('data', 'doctors')).to eq([])
  end
end
