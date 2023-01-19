# bundle exec rspec spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:username).of_type(:string) }
    it { is_expected.to have_db_column(:phone_number).of_type(:string) }
    it { is_expected.to have_db_column(:type).of_type(:string) }
  end

  describe 'validation' do
    context 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to allow_value(Faker::Internet.unique.email).for(:email) }
      it { is_expected.not_to allow_value('micheal.kassulke@').for(:email) }
    end

    context 'username' do
      it { is_expected.to validate_presence_of(:username) }
    end

    context 'phone_number' do
      it { is_expected.to validate_presence_of(:phone_number) }
    end

    context 'user types' do
      it 'should allow valid values' do
        User::TYPES.each_key do |key|
          should allow_value(key).for(:type)
        end
      end
    end
  end
end
