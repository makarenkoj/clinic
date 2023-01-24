require 'rails_helper'

describe Admin::PatientProfilesController, type: :controller do
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { create(:admin_user, password: '123456') }
  let!(:user) { create(:user, :patient_type) }

  describe 'GET index' do
    context 'if admin user un asign' do
      before { get :index }

      it 'redirect to login page' do
        expect(response.status).to eq(302)
        expect(response).to have_http_status(:redirect)
      end

      it 'return notice' do
        expect(flash[:alert]).to match('You need to sign in or sign up before continuing.')
      end
    end

    context 'if admin user sign in' do
      before { sign_in admin_user }

      it 'returns http success' do
        sign_in admin_user
        get :index

        expect(response).to have_http_status(:success)
      end

      it 'assigns the admnin user' do
        get :index

        expect(AdminUser.count).to eq(1)
      end
    end
  end

  describe 'GET show' do
    before { sign_in admin_user }

    it 'returns http success' do
      get :show, params: { id: user.patient_profile.id }

      expect(response).to have_http_status(:success)
    end

    it 'should render the form elements' do
      get :show, params: { id: user.patient_profile.id }

      expect(page).to have_content(user.username)
      expect(page).to have_content(user.phone_number)
      expect(page).to have_content(user.email)
    end
  end
end
