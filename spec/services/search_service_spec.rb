require 'rails_helper'

# rspec spec/services/search_service_spec.rb

describe SearchService do
  let!(:current_user) { create(:user, :patient_type) }

  let(:category1) { create(:category, name_en: 'category1') }
  let(:category2) { create(:category, name_en: 'category2') }
  let(:category3) { create(:category, name_en: 'category3') }

  let(:doctor1) { create(:doctor_profile) }
  let(:doctor2) { create(:doctor_profile) }
  let(:doctor3) { create(:doctor_profile) }

  let!(:categories_doctor1) { create(:categories_doctor, doctor_profile: doctor1, category: category1) }
  let!(:categories_doctor2) { create(:categories_doctor, doctor_profile: doctor2, category: category2) }
  let!(:categories_doctor3) { create(:categories_doctor, doctor_profile: doctor3, category: category3) }
  let!(:categories_doctor4) { create(:categories_doctor, doctor_profile: doctor2, category: category3) }

  it 'should return doctors by categories' do
    expect(SearchService.call(search: category1.name_en).size).to eql 1
    expect(SearchService.call(search: category1.name_en)[0]).to eql doctor1.user
    expect(SearchService.call(search: category3.name_en).size).to eql 2
  end

  it 'should return doctors by username' do
    expect(SearchService.call(search: doctor1.user.username).size).to eql 1
    expect(SearchService.call(search: doctor1.user.username)[0]).to eql doctor1.user
  end

  it 'should return nil' do
    expect(SearchService.call().size).to eql 0
  end
end
