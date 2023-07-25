require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'GET /internal_server_error' do
    it 'returns http success' do
      get '/500'
      expect(response).to have_http_status(:server_error)
    end
  end

  describe 'GET /not_found' do
    it 'returns http success' do
      get '/404'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /unprocessable_content' do
    it 'returns http success' do
      get '/422'
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
