require 'rails_helper'

RSpec.describe Note, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:date_time).of_type(:datetime) }
    it { is_expected.to have_db_column(:body).of_type(:string) }
  end

  describe 'asociation' do
    it { should belong_to(:user) }
  end

  describe 'validation' do
    context 'presents' do
      it { is_expected.to validate_presence_of(:date_time) }
      it { is_expected.to validate_presence_of(:body) }
    end
  end
end
