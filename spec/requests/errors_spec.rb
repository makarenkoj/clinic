require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'GET /internal_server_error' do
    it 'returns http success' do
      get '/errors/internal_server_error'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /not_found' do
    it 'returns http success' do
      get '/errors/not_found'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /unprocessable_content' do
    it 'returns http success' do
      get '/errors/unprocessable_content'
      expect(response).to have_http_status(:success)
    end
  end
end
