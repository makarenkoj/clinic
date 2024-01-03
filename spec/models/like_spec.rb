require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:message_id).of_type(:integer) }
  end

  describe 'asociation' do
    it { should belong_to(:user) }
    it { should belong_to(:message) }
  end
end
