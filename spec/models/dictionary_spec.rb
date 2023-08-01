require 'rails_helper'

RSpec.describe Dictionary, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:language).of_type(:string) }
  end

  context 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:language) }
  end

  describe 'asociation' do
    it { should belong_to(:user) }
    it { should have_many(:words) }
  end
end
