# bundle exec rspec spec/requests/doctors_appointments_spec.rb

require 'rails_helper'

RSpec.describe '/doctors_appointments', type: :request do
  let!(:current_user) { create(:user, :patient_type) }

  describe 'GET /show' do
    it 'renders a successful response' do
      sign_in current_user
      appointment = create(:doctors_appointment, patient_profile: current_user.patient_profile)

      get "/doctors_appointments/#{appointment.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'user not autorized' do
      appointment = create(:doctors_appointment, patient_profile: current_user.patient_profile)

      get "/doctors_appointments/#{appointment.id}"

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'POST /create' do
    # it 'create appointment ' do
    #   sign_in current_user
    #   doctor = create(:user, :doctor_type)
    #   params = { doctors_appointment: { doctor_profile: doctor.username, visit_time: Time.current + 2.days } }

    #   post '/doctors_appointments', params: params

    #   current_user.reload
    #   expect(response).to have_http_status(:found)
    #   expect(response).to redirect_to(current_user.patient_profile)
    #   expect(current_user.patient_profile.doctors_appointments.size).to eq(1)
    #   expect(current_user
    #         .patient_profile
    #         .doctors_appointments
    #         .last.visit_time
    #         .strftime('%H:%M %d/%m/%Y')).to eq(params[:doctors_appointment][:visit_time].strftime('%H:%M %d/%m/%Y'))
    #   expect(current_user.patient_profile.doctors_appointments.last.doctor_profile).to eq(doctor.doctor_profile)
    #   expect(current_user.patient_profile.doctors_appointments.last.description).to eq(nil)
    # end

    it 'not doctor' do
      sign_in current_user
      not_doctor = create(:user, :patient_type)
      params = { doctors_appointment: { doctor_profile: not_doctor.username, visit_time: Time.current + 2.days } }

      post '/doctors_appointments', params: params

      current_user.reload
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(doctor_profiles_url)
      expect(current_user.patient_profile.doctors_appointments.size).to eq(0)
    end

    it 'user not autorize' do
      not_doctor = create(:user, :patient_type)
      params = { doctors_appointment: { doctor_profile: not_doctor.username, visit_time: Time.current + 2.days } }

      post '/doctors_appointments', params: params

      current_user.reload
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_url)
      expect(current_user.patient_profile.doctors_appointments.size).to eq(0)
    end
  end

  describe 'PATCH /update' do
    # TODO
  end

  describe 'DELETE /destroy' do
    # TODO
  end
end
