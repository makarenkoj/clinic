require 'rails_helper'

RSpec.describe 'Pixels', type: :request do
  let(:current_user) { create(:user, :patient_type) }

  describe 'GET/index' do
    let!(:pixels) { create_list(:pixel, 5) }

    it 'return list pixels' do
      get '/pixels/'

      data = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(data.size).to eql 5
    end

    it 'return list pixels current_user' do
      sign_in current_user

      get '/pixels/'

      data = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(data.size).to eql 5
      expect(current_user.present?).to be true
    end
  end

  describe 'POST/create' do
    it 'create pixels' do
      sign_in current_user
      params = { pixel: { x: 3, y: 10 } }

      post '/pixels', params: params

      data = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(data['x']).to eql params[:pixel][:x]
      expect(data['x']).to eql params[:pixel][:x]
      expect(data['user_id']).to eql current_user.id
    end

    it 'create pixels user not authorize' do
      params = { pixel: { x: 3, y: 10 } }

      post '/pixels', params: params

      expect(response).to have_http_status(:found)
      expect(Pixel.last).to eql nil
      expect(flash['alert']).to eql 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'PUT/update' do
    it 'update pixel' do
      sign_in current_user

      pixel = create(:pixel, x: 1, y: 2, user: current_user)
      params = { pixel: { x: 3, y: 10 } }

      put "/pixels/#{pixel.id}", params: params

      data = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(data['x']).to eql params[:pixel][:x]
      expect(data['x']).to eql params[:pixel][:x]
      expect(data['user_id']).to eql current_user.id
      pixel.reload
      expect(pixel.x).to eql params[:pixel][:x]
      expect(pixel.y).to eql params[:pixel][:y]
    end

    it 'user unathorized' do
      pixel = create(:pixel, x: 1, y: 2, user: current_user)
      params = { pixel: { x: 3, y: 10 } }

      put "/pixels/#{pixel.id}", params: params

      expect(response).to have_http_status(:found)
      pixel.reload
      expect(pixel.x).to_not eql params[:pixel][:x]
      expect(pixel.y).to_not eql params[:pixel][:y]
      expect(flash['alert']).to eql 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'PUT/delete_all' do
    it 'delete pixel' do
      sign_in current_user

      create_list(:pixel, 5, x: 1, y: 2, user: current_user)

      expect(current_user.pixels.size).to eql 5

      put '/pixels/delete_all'

      expect(response).to have_http_status(:found)
      expect(current_user.reload.pixels.size).to eql 0
      expect(flash['notice']).to eql I18n.t('pages.secret.clear')
    end

    it 'user not authorized' do
      create_list(:pixel, 5, x: 1, y: 2, user: current_user)

      expect(current_user.pixels.size).to eql 5

      put '/pixels/delete_all'

      expect(response).to have_http_status(:found)
      expect(current_user.reload.pixels.size).to eql 5
      expect(flash['alert']).to eql 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'PUT/delete_last' do
    it 'delete last pixel' do
      sign_in current_user

      create_list(:pixel, 5, x: 1, y: 2, user: current_user)

      expect(current_user.pixels.size).to eql 5

      put '/pixels/delete_last'

      expect(response).to have_http_status(:found)
      expect(current_user.reload.pixels.size).to eql 4
      expect(flash['notice']).to eql I18n.t('pages.secret.last')
    end

    it 'user not authorized' do
      create_list(:pixel, 5, x: 1, y: 2, user: current_user)

      expect(current_user.pixels.size).to eql 5

      put '/pixels/delete_last'

      expect(response).to have_http_status(:found)
      expect(current_user.reload.pixels.size).to eql 5
      expect(flash['alert']).to eql 'You need to sign in or sign up before continuing.'
    end
  end
end
