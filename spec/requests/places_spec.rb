require 'rails_helper'

RSpec.describe '/places', type: :request do
  let(:current_user) { create(:user, :doctor_type) }
  let(:patient_user) { create(:user, :patient_type) }
  let(:place) { create(:place, doctor_profile: current_user.doctor_profile) }

  describe 'GET /show' do
    it 'renders a successful response' do
      sign_in current_user

      get "/doctor_profiles/#{current_user.doctor_profile.id}/places/#{place.id}"
      expect(response).to be_successful
    end

    it 'redirects to the sign-in page if not signed in' do
      get "/doctor_profiles/#{current_user.doctor_profile.id}/places/#{place.id}"
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'renders a successful response if not a doctor' do
      sign_in patient_user

      get "/doctor_profiles/#{current_user.doctor_profile.id}/places/#{place.id}"
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      sign_in current_user

      get "/doctor_profiles/#{place.doctor_profile.id}/places/new"
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      sign_in current_user

      get "/doctor_profiles/#{place.doctor_profile.id}/places/#{place.id}/edit"
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Place' do
        sign_in current_user

        expect do
          post "/doctor_profiles/#{place.doctor_profile.id}/places", params: { place: { name: 'Paris', location: 'Paris' } }
        end.to change(Place, :count).by(1)
      end

      it 'redirects to the created place' do
        sign_in current_user
  
        post "/doctor_profiles/#{place.doctor_profile.id}/places", params: { place: { name: 'Paris', location: 'Paris' } }
        expect(response).to redirect_to(doctor_profile_place_path(Place.last.doctor_profile.id, Place.last.id))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Place' do
        sign_in current_user

        expect do
          post "/doctor_profiles/#{place.doctor_profile.id}/places", params: { place: { name: '', location: '' } }
        end.to change(Place, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        sign_in current_user
  
        post "/doctor_profiles/#{place.doctor_profile.id}/places", params: { place: { name: '', location: '' } }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested place' do
        sign_in current_user

        patch "/doctor_profiles/#{place.doctor_profile.id}/places/#{place.id}", params: { place: { name: 'Milano', location: 'Milano' } }

        place.reload
        expect(response).to redirect_to(doctor_profile_place_path(current_user.doctor_profile.id, place.id))
        expect(place.name).to eq('Milano')
        expect(place.location).to eq('Milano')
      end

      it 'redirects if user not login' do
        patch "/doctor_profiles/#{place.doctor_profile.id}/places/#{place.id}", params: { place: { name: 'Milano', location: 'Milano' } }

        place.reload
        expect(response).to redirect_to(new_user_session_path)
        expect(place.name).to eq('London')
        expect(place.location).to eq('London')
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        sign_in current_user

        patch "/doctor_profiles/#{place.doctor_profile.id}/places/#{place.id}", params: { place: { name: '', location: '' } }

        place.reload
        expect(response).to be_successful
        expect(place.name).to eq('London')
        expect(place.location).to eq('London')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested place' do
      sign_in current_user
      place_destroy = create(:place, doctor_profile: current_user.doctor_profile)

      expect do
        delete "/doctor_profiles/#{place_destroy.doctor_profile.id}/places/#{place_destroy.id}"
      end.to change(Place, :count).by(-1)
    end

    it 'redirects to the places list' do
      sign_in current_user

      delete "/doctor_profiles/#{place.doctor_profile.id}/places/#{place.id}"
      expect(response).to redirect_to(doctor_profile_path(current_user.doctor_profile.id))
    end

    it 'destroys the requested place' do
      place_destroy = create(:place, doctor_profile: current_user.doctor_profile)

      expect do
        delete "/doctor_profiles/#{place_destroy.doctor_profile.id}/places/#{place_destroy.id}"
      end.to change(Place, :count).by(0)
    end
  end
end
