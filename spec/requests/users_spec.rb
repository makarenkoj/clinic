# bundle exec rspec spec/requests/users_spec.rb

require 'rails_helper'

RSpec.describe '/users', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get '/users'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = create(:user, :patient_type)
      sign_in user

      get "/users/#{user.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'user not autorized' do
      user = create(:user, :patient_type)

      get "/users/#{user.id}"
      expect(response).to have_http_status(:found)
    end
  end

  describe 'PATCH /update' do
    it 'updates user' do
      phone_number = '+380662843377'
      user = create(:user, :patient_type, phone_number: '+380997465533', username: 'test', email: 'mail@mail.com')
      sign_in user

      put "/users/#{user.id}", params: { user: { phone_number: phone_number } }

      expect(user.reload.phone_number).to eq(phone_number)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(user.patient_profile)
    end

    it 'user not autorized' do
      phone_number = '+380602843377'
      user = create(:user, :patient_type, phone_number: '+380997465533', username: 'test', email: 'mail@mail.com')

      put "/users/#{user.id}", params: { user: { phone_number: phone_number } }

      user.reload
      expect(user.phone_number).to eq(user.phone_number)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'with invalid parameters' do
      phone_number = '+380602843377jfdfkndkfk'
      user = create(:user, :patient_type, phone_number: '+380997465533', username: 'test', email: 'mail@mail.com')
      sign_in user

      put "/users/#{user.id}", params: { user: { phone_number: phone_number } }

      user.reload
      expect(user.phone_number).to eq(user.phone_number)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys user' do
      user = create(:user, :patient_type)
      sign_in user

      expect do
        delete "/users/#{user.id}"
      end.to change(User, :count).by(-1)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_url)
    end
  end
end
