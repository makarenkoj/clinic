require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:room_id).of_type(:integer) }
    it { is_expected.to have_db_column(:likes_count).of_type(:integer) }
    it { is_expected.to have_db_column(:body).of_type(:string) }
  end

  describe 'asociation' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
    it { should have_many(:likes) }
  end

  describe 'validation' do
    it { should validate_presence_of(:body) }
  end
end
