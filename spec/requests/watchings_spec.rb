# bundle exec rspec spec/requests/watchings_spec.rb

require 'rails_helper'

RSpec.describe '/watchings', type: :request do
  let!(:current_user) { create(:user, :patient_type, email: 'makarenkoj53@gmail.com') }
  let!(:bad_user) { create(:user, :patient_type) }
  let!(:watching) { create(:watching) }
  let(:watchings) { create_list(:watching, 5) }
  let(:params) do 
    { ip: '37.161.126.232',
      continent_code: 'EU',
      continent_name: 'Europe',
      country_code2: 'IT',
      country_code3: 'ITA',
      country_name: 'Italy',
      country_name_official: 'Republic of Italy',
      country_capital: 'Rome', 
      state_prov: 'Lombardy', 
      state_code: 'IT-25', 
      district: 'test', 
      city: 'Milan', 
      zipcode: '20145', 
      latitude: '45.47897', 
      longitude: '9.16516', 
      is_eu: true, 
      calling_code: '+39', 
      country_tld: '.it', 
      languages: 'it-IT,de-IT,fr-IT,sc,ca,co,sl', 
      country_flag: 'https://ipgeolocation.io/static/flags/it_64.png', 
      geoname_id: '6519349', 
      isp: 'Iliad Italia', 
      connection_type: 'test', 
      organization: 'SCALEWAY S.A.S.', 
      country_emoji: '🇮🇹', 
      currency: { code: 'EUR', name: 'Euro', symbol: '€' }, 
      time_zone: { name: 'Europe/Rome', 
                   offset: 1, 
                   offset_with_dst: 2,
                   current_time: '2024-08-29 22:08:24.586+0200', 
                   current_time_unix: 1_724_962_104.586,
                   is_dst: true,
                   dst_savings: 1,
                   dst_exists: true, 
                   dst_start: { utc_time: '2024-03-31 TIME 01',
                                duration: '+1H',
                                gap: true,
                                date_time_after: '2024-03-31 TIME 03',
                                date_time_before: '2024-03-31 TIME 02',
                                overlap: false }, 
                   dst_end: { utc_time: '2024-10-27 TIME 01',
                              duration: '-1H',
                              gap: false,
                              date_time_after: '2024-10-27 TIME 02',
                              date_time_before: '2024-10-27 TIME 03',
                              overlap: true } } }
  end

  let(:invalid_params) do 
    { continent_code: 'EU',
      continent_name: 'Europe',
      country_code2: 'IT',
      country_code3: 'ITA',
      country_name: 'Italy',
      country_name_official: 'Republic of Italy',
      country_capital: 'Rome', 
      state_prov: 'Lombardy', 
      state_code: 'IT-25', 
      district: 'test', 
      city: 'Milan', 
      zipcode: '20145', 
      latitude: '45.47897', 
      longitude: '9.16516', 
      is_eu: true, 
      calling_code: '+39', 
      country_tld: '.it', 
      languages: 'it-IT,de-IT,fr-IT,sc,ca,co,sl', 
      country_flag: 'https://ipgeolocation.io/static/flags/it_64.png', 
      geoname_id: '6519349', 
      isp: 'Iliad Italia', 
      connection_type: 'test', 
      organization: 'SCALEWAY S.A.S.', 
      country_emoji: '🇮🇹', 
      currency: { code: 'EUR', name: 'Euro', symbol: '€' }, 
      time_zone: { name: 'Europe/Rome',
                   offset: 1, 
                   offset_with_dst: 2, 
                   current_time: '2024-08-29 22:08:24.586+0200', 
                   current_time_unix: 1_724_962_104.586,
                   is_dst: true,
                   dst_savings: 1,
                   dst_exists: true, 
                   dst_start: { utc_time: '2024-03-31 TIME 01',
                                duration: '+1H',
                                gap: true,
                                date_time_after: '2024-03-31 TIME 03',
                                date_time_before: '2024-03-31 TIME 02',
                                overlap: false }, 
                   dst_end: { utc_time: '2024-10-27 TIME 01',
                              duration: '-1H',
                              gap: false,
                              date_time_after: '2024-10-27 TIME 02',
                              date_time_before: '2024-10-27 TIME 03',
                              overlap: true } } }
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
