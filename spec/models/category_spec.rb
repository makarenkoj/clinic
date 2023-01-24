require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:name_en).of_type(:string) }
    it { is_expected.to have_db_column(:name_ua).of_type(:string) }
  end

  describe 'asociation' do
    it { should have_many(:categories_doctors).dependent(:restrict_with_error) }
    it { should have_many(:doctor_profiles).through(:categories_doctors) }
  end

  describe 'validation' do
    it { should validate_presence_of(:name_en) }
    it { should validate_presence_of(:name_ua) }
  end
end
