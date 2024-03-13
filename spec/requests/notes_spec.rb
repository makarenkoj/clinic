require 'rails_helper'

RSpec.describe 'Notes', type: :request do
  let(:current_user) { create(:user, :patient_type) }

  describe 'Index' do
    let(:notes) { create_list(:note, 5) }

    it 'returns http success' do
      sign_in current_user

      get '/notes'
      expect(response).to have_http_status(:success)
    end
  end
end
