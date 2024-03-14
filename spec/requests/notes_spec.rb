require 'rails_helper'

RSpec.describe 'Notes', type: :request do
  let(:current_user) { create(:user, :patient_type) }

  describe 'Show' do
    it 'renders a successful response' do
      sign_in current_user
      note = create(:note, user: current_user)

      get "/notes/#{note.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'user not autorized' do
      note = create(:note, user: current_user)
      get "/notes/#{note.id}"

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_url)
      expect(flash['alert']).to eql 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'Index' do
    let(:notes) { create_list(:note, 5, user: current_user) }

    it 'returns http success' do
      sign_in current_user

      get '/notes'
      expect(response).to have_http_status(:success)
    end

    it 'user not autorized' do
      get '/notes'

      expect(response).to have_http_status(:redirect)
      expect(flash['alert']).to eql 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'Update' do
    let(:note) { create(:note, user: current_user, body: 'Not update') }

    it 'returns http success' do
      sign_in current_user

      put "/notes/#{note.id}", params: { note: { body: 'Test' } }

      expect(response).to have_http_status(:redirect)
      expect(note.reload.body).to eql 'Test'
    end

    it 'user not autorized' do
      put "/notes/#{note.id}", params: { note: { body: 'Test' } }

      expect(response).to have_http_status(:redirect)
      expect(note.reload.body).to eql 'Not update'
      expect(flash['alert']).to eql 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'Create' do
    it 'returns http success' do
      sign_in current_user

      post '/notes/', params: { note: { body: 'Create new notes', date_time: Time.now } }

      expect(response).to have_http_status(:redirect)
      expect(current_user.notes.last.body).to eql 'Create new notes'
    end

    it 'broken data' do
      sign_in current_user

      post '/notes/', params: { note: { body: '', date_time: 'broken' } }

      expect(response).to have_http_status(:redirect)
      expect(current_user.notes.last.body).to eql ''
      expect(flash['notice']).to eql "can't be blank<br>can't be blank"
    end

    it 'user not autorized' do
      post '/notes/', params: { note: { body: 'Create new notes', date_time: Time.now } }

      expect(response).to have_http_status(:redirect)
      expect(flash['alert']).to eql 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'Destroy' do
    let(:note) { create(:note, user: current_user, body: 'Destroy') }

    it 'returns http success' do
      sign_in current_user

      delete "/notes/#{note.id}"

      expect(response).to have_http_status(:redirect)
      expect(Note.find_by(id: note.id)).to be nil
      expect(flash['notice']).to eql'User was successfully deleted :('
    end

    it 'user not autorized' do
      delete "/notes/#{note.id}"

      expect(response).to have_http_status(:redirect)
      expect(flash['alert']).to eql 'You need to sign in or sign up before continuing.'
    end
  end
end
