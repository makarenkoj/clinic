require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /space' do
    let(:current_user) { create(:user, :patient_type) }

    it 'returns http success' do
      sign_in current_user

      get '/pages/space'
      expect(response).to have_http_status(:success)
    end
  end
end
