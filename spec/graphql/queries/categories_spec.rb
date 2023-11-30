require 'rails_helper'

RSpec.describe 'query categories' do
  it 'return all categories' do
    create_list(:category, 5)
    category = create(:category)
    doctor_profile = create(:doctor_profile)
    doctor_profile.categories << category
  
    query = <<~GQL
      query {
        categories {
            id
            nameUa
            nameEn
            doctors {
              id
              userId
            }
          }
        }
    GQL
  
    result = ClinicSchema.execute(query)

    expect(result.dig('data', 'categories').size).to eq(6)
    expect(result.dig('data', 'categories').last['doctors'].first['id']).to eq(doctor_profile.id.to_s)
  end

  it "when don't have categories" do
    query = <<~GQL
      query {
        categories {
            id
            nameUa
            nameEn
            doctors {
              id
              userId
            }
          }
        }
    GQL
  
    result = ClinicSchema.execute(query)

    expect(result.dig('data', 'categories').size).to eq(0)
  end
end
