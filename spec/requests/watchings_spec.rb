# bundle exec rspec spec/requests/watchings_spec.rb

require 'rails_helper'

RSpec.describe '/watchings', type: :request do
  # describe 'GET /index' do
  #   it 'renders a successful response' do
  #     get '/watchings'

  #     expect(response).to have_http_status(:ok)
  #   end
  # end

  # describe 'GET /show' do
  #   it 'renders a successful response' do

  #     get "/watchings/#{user.id}"
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it 'user not autorized' do

  #     get "/watchings/#{user.id}"
  #     expect(response).to have_http_status(:found)
  #   end
  # end

  describe 'POST /create' do
    params = { status: 'success',
               country: 'Italy',
               country_code: 'IT',
               region: '25',
               region_name: 'Lombardy',
               city: 'Milano',
               zip: '',
               lat: 45.4642,
               lon: 9.1899,
               timezone: 'Europe/Rome',
               isp: 'Iliad Italia',
               org: 'Iliad Italia S.p.A',
               as: 'AS29447 SCALEWAY S.A.S.',
               proxy: false,
               hosting: false,
               query: '37.161.208.3',
               ip: '37.161.208.3' }
    
    it 'renders a successful response' do
      post '/watchings', params: { watching: params }

      data = JSON.parse(response.body)
      binding.break

      expect(response).to have_http_status(:ok)
    end
  end

  # describe 'PATCH /update' do
  # it 'updates user' do
  #   phone_number = '+380662843377'
  #   user = create(:user, :patient_type, phone_number: '+380997465533', username: 'test', email: 'mail@mail.com')
  #   sign_in user

  #   put "/users/#{user.id}", params: { user: { phone_number: phone_number } }

  #   expect(user.reload.phone_number).to eq(phone_number)
  #   expect(response).to have_http_status(:found)
  #   expect(response).to redirect_to(user.patient_profile)
  # end

  # it 'user not autorized' do
  #   phone_number = '+380602843377'
  #   user = create(:user, :patient_type, phone_number: '+380997465533', username: 'test', email: 'mail@mail.com')

  #   put "/users/#{user.id}", params: { user: { phone_number: phone_number } }

  #   user.reload
  #   expect(user.phone_number).to eq(user.phone_number)
  #   expect(response).to have_http_status(:found)
  #   expect(response).to redirect_to(new_user_session_path)
  # end

  # it 'with invalid parameters' do
  #   phone_number = '+380602843377jfdfkndkfk'
  #   user = create(:user, :patient_type, phone_number: '+380997465533', username: 'test', email: 'mail@mail.com')
  #   sign_in user

  #   put "/users/#{user.id}", params: { user: { phone_number: phone_number } }

  #   user.reload
  #   expect(user.phone_number).to eq(user.phone_number)
  #   expect(response).to have_http_status(:ok)
  # end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys user' do
  #     user = create(:user, :patient_type)
  #     sign_in user

  #     expect do
  #       delete "/users/#{user.id}"
  #     end.to change(User, :count).by(-1)

  #     expect(response).to have_http_status(:found)
  #     expect(response).to redirect_to(root_url)
  #   end
  # end
end
