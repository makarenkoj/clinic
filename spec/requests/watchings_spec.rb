# bundle exec rspec spec/requests/watchings_spec.rb

require 'rails_helper'

RSpec.describe '/watchings', type: :request do
  let!(:current_user) { create(:user, :patient_type, email: 'makarenkoj53@gmail.com') }
  let!(:bad_user) { create(:user, :patient_type) }
  let!(:watching) { create(:watching) }
  let(:watchings) { create_list(:watching, 5) }
  let(:params) do 
    { status: 'success',
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
  end
  let(:invalid_params) do 
    { status: 'success',
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
      query: '37.161.208.3' }
  end
  

  describe 'GET /index' do
    it 'renders a successful response' do
      sign_in current_user

      get '/watchings'

      expect(response).to have_http_status(:ok)
    end

    it 'renders a bad response' do
      sign_in bad_user

      get '/watchings'

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      sign_in current_user

      get "/watchings/#{watching.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'renders a bad response' do
      sign_in bad_user

      get "/watchings/#{watching.id}"

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'POST /create' do
    it 'renders a successful response' do
      post '/watchings', params: { watching: params }

      data = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(data['watching']['ip']).to eql(params[:ip])
    end

    it 'without ip' do
      post '/watchings', params: { watching: invalid_params }

      data = JSON.parse(response.body)
      expect(response).to have_http_status(:bad_request)
      expect(data['error']['ip']).to eql("can't be blank")
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys watchings' do
      sign_in current_user

      expect { delete "/watchings/#{watching.id}", params: { id: watching.id } }.to change(Watching, :count).by(-1)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(watchings_path)
      expect(flash[:notice]).to eq(I18n.t('view.watching.destroyed'))
    end

    it 'did`nt destroys watchings' do
      sign_in bad_user

      expect { delete "/watchings/#{watching.id}", params: { id: watching.id } }.not_to change(Watching, :count)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
    end
  end
end
