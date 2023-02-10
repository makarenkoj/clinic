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
    context 'validation visit time' do
      it { should validate_presence_of(:visit_time) }

      it 'visit time valid' do
        expect(create(:doctors_appointment, visit_time: Time.current + 1.days)).to be_valid
      end

      it 'visit time invalid' do
        expect do 
          create(:doctors_appointment, visit_time: Time.current)
        end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Visit time Visit time must be greater than the current date')
      end
    end

    context 'validation doctors' do
      let!(:doctor) { create(:doctor_profile) }

      it 'visit time valid' do
        expect(create(:doctors_appointment, visit_time: Time.current + 1.days)).to be_valid
      end

      it 'should return Visit time must be greater than' do
        expect do 
          create(:doctors_appointment, visit_time: Time.current)
        end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Visit time Visit time must be greater than the current date')
      end
    end
  end
end
