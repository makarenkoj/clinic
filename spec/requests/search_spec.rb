# bundle exec rspec spec/requests/search_spec.rb

require 'rails_helper'

RSpec.describe '/search', type: :request do
  include_context 'base'

  let!(:current_user) { create(:user, :patient_type) }

  describe 'GET /index' do
    it 'renders a successful response' do
      sign_in current_user

      get '/search'

      expect(response).to have_http_status(:ok)
      expect(current_user.present?).to be true
    end

    it 'redirect to login' do

      get '/search'

      expect(response).to have_http_status(:found)
    end
  end

  describe 'POST /search/search' do
    it 'renders a successful response' do
      sign_in current_user

      post '/search/search'

      expect(response).to have_http_status(:ok)
      expect(current_user.present?).to be true
    end

    it 'renders a successful response' do
      sign_in current_user
      doctor = create(:user, :doctor_type)
      params = { search: doctor.username }

      post '/search/search', params: params

      expect(response).to have_http_status(:ok)
      expect(current_user.present?).to be true
      expect(assigns(:results)[0]).to eq(doctor)
    end

    it 'not login user' do
      doctor = create(:user, :doctor_type)
      params = { search: doctor.username }

      post '/search/search', params: params

      expect(response).to have_http_status(:found)
    end
  end
end
