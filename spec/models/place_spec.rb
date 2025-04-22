require 'rails_helper'

RSpec.describe Place, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:location).of_type(:string) }
    it { is_expected.to have_db_column(:x).of_type(:decimal) }
    it { is_expected.to have_db_column(:y).of_type(:decimal) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:location) }
  end
end
