require 'rails_helper'

RSpec.describe PatientProfile, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:description).of_type(:text) }
  end

  describe 'asociation' do
    it { should belong_to(:user) }
    it { should have_many(:doctors_appointments) }
    it { should have_many(:doctor_profiles).through(:doctors_appointments) }
  end
end
