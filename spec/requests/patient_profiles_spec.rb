# bundle exec rspec spec/requests/patient_profiles_spec.rb

require 'rails_helper'

RSpec.describe '/patient_profiles', type: :request do
  let!(:current_user) { create(:user, :patient_type) }
  let!(:doctor_user) { create(:user, :doctor_type) }

  describe 'GET /index' do
    it 'redirect when patients page' do
      sign_in current_user

      get '/patient_profiles'

      expect(response).to have_http_status(:found)
    end

    it 'renders a successful response when doctor' do
      sign_in doctor_user

      get '/patient_profiles'

      expect(response).to have_http_status(:ok)
    end

    it 'redirect when user not autorized' do
      get '/patient_profiles'

      expect(response).to have_http_status(:found)
    end

    it 'redirect when doctor not autorized' do
      get '/patient_profiles'

      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response when patient page' do
      sign_in current_user

      get "/patient_profiles/#{current_user.patient_profile.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'renders a successful response when doctor have appointment' do
      sign_in doctor_user

      create(:doctors_appointment, patient_profile: current_user.patient_profile, doctor_profile: doctor_user.doctor_profile)

      get "/patient_profiles/#{current_user.patient_profile.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'renders a successful response when doctor looks patient page' do
      sign_in doctor_user

      get "/patient_profiles/#{current_user.patient_profile.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'redirect when patient looks other patient page' do
      patient = create(:user, :patient_type)
      sign_in current_user

      get "/patient_profiles/#{patient.patient_profile.id}"

      expect(response).to have_http_status(:found)
    end

    it 'user not autorized' do
      get "/patient_profiles/#{current_user.patient_profile.id}"

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'PATCH /update' do
    it 'successful update' do
      sign_in current_user

      put "/patient_profiles/#{current_user.patient_profile.id}", params: { patient_profile: { description: 'Update now description' } }

      expect(response).to have_http_status(:found)
      expect(current_user.patient_profile.reload.description).to eq('Update now description')
    end

    it 'user not autorized' do
      put "/patient_profiles/#{current_user.patient_profile.id}", params: { patient_profile: { description: 'Update now description' } }

      expect(response).to have_http_status(:found)
      expect(current_user.patient_profile.reload.description).not_to eq('Update now description')
    end
  end
end
