# bundle exec rspec spec/models/watching_spec.rb
require 'rails_helper'

RSpec.describe Watching, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:ip).of_type(:string) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:isp).of_type(:string) }
    it { is_expected.to have_db_column(:viewing).of_type(:integer) }
    it { is_expected.to have_db_column(:continent_code).of_type(:string) }
    it { is_expected.to have_db_column(:continent_name).of_type(:string) }
    it { is_expected.to have_db_column(:country_code2).of_type(:string) }
    it { is_expected.to have_db_column(:country_code3).of_type(:string) }
    it { is_expected.to have_db_column(:country_name).of_type(:string) }
    it { is_expected.to have_db_column(:country_name_official).of_type(:string) }
    it { is_expected.to have_db_column(:country_capital).of_type(:string) }
    it { is_expected.to have_db_column(:state_prov).of_type(:string) }
    it { is_expected.to have_db_column(:state_code).of_type(:string) }
    it { is_expected.to have_db_column(:district).of_type(:string) }
    it { is_expected.to have_db_column(:zipcode).of_type(:string) }
    it { is_expected.to have_db_column(:latitude).of_type(:string) }
    it { is_expected.to have_db_column(:longitude).of_type(:string) }
    it { is_expected.to have_db_column(:is_eu).of_type(:string) }
    it { is_expected.to have_db_column(:calling_code).of_type(:string) }
    it { is_expected.to have_db_column(:country_tld).of_type(:string) }
    it { is_expected.to have_db_column(:languages).of_type(:string) }
    it { is_expected.to have_db_column(:country_flag).of_type(:string) }
    it { is_expected.to have_db_column(:geoname_id).of_type(:string) }
    it { is_expected.to have_db_column(:connection_type).of_type(:string) }
    it { is_expected.to have_db_column(:organization).of_type(:string) }
    it { is_expected.to have_db_column(:country_emoji).of_type(:string) }
    it { is_expected.to have_db_column(:currency).of_type(:jsonb) }
    it { is_expected.to have_db_column(:time_zone).of_type(:jsonb) }
  end

  describe 'validations' do
    it { should validate_presence_of(:ip) }
    
    it 'validates uniqueness of ip, case-insensitively' do
      create(:watching, ip: '127.0.0.1')
      watching2 = build(:watching, ip: '127.0.0.1')

      expect(watching2).to be_invalid
      expect(watching2.errors[:ip]).to include('has already been taken')
    end
  end
end
