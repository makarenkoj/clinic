# bundle exec rspec spec/models/pixel_spec.rb
require 'rails_helper'

RSpec.describe Pixel, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:x).of_type(:integer) }
    it { is_expected.to have_db_column(:y).of_type(:integer) }
    it { is_expected.to have_db_column(:color).of_type(:string) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
  end

  describe 'asociation' do
    it { should belong_to(:user) }
  end
end
