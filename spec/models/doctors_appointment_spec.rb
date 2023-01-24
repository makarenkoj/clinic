require 'rails_helper'

RSpec.describe DoctorsAppointment, type: :model do
  context 'fields' do
    it { is_expected.to have_db_column(:visit_time).of_type(:datetime) }
  end

  describe 'asociation' do
    it { should belong_to(:doctor_profile) }
    it { should belong_to(:patient_profile) }
  end
  
  describe 'validation' do
    it { should validate_presence_of(:visit_time) }
  end
end
