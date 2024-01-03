require 'rails_helper'

RSpec.describe Room, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:title).of_type(:string) }
  end

  describe 'asociation' do
    it { should belong_to(:user) }
    it { should have_many(:messages).dependent(:destroy) }
  end
end
