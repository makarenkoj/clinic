require 'rails_helper'

RSpec.describe Word, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:original).of_type(:string) }
    it { is_expected.to have_db_column(:translate).of_type(:string) }
  end

  context 'validation' do
    it { is_expected.to validate_presence_of(:original) }
    it { is_expected.to validate_presence_of(:translate) }
  end

  describe 'asociation' do
    it { should belong_to(:dictionary) }
  end
end
