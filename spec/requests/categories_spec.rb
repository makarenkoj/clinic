# bundle exec rspec spec/requests/categories_spec.rb

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe '#create' do
    let(:valid_params) { { category: { name_ua: 'Category 1', name_en: 'Categoria 1' } } }
    let(:invalid_params) { { category: { name_ua: '' } } }

    context 'with valid params' do
      it 'creates a new category' do
        expect { post :create, params: valid_params }.to change(Category, :count).by(1)
      end
    end

    # context 'with invalid params' do
    #   it 'renders the new template' do
    #     post :create, params: invalid_params
    #     expect(response).to render_template(:new)
    #   end
    # end
  end

  describe '#index' do
    let!(:categories) { create_list(:category, 12) }

    context 'with no pagination params' do
      it 'returns the first 10 categories' do
        get :index
        expect(assigns(:categories).count).to eq(10)
        expect(assigns(:next_categories)).to eq(categories[10])
      end
    end

    # context 'with pagination params' do
    #   it 'returns the next 10 categories' do
    #     get :index, params: { next_categories: categories[9].id }

    #     expect(assigns(:categories).count).to eq(10)
    #     expect(assigns(:next_categories)).to eq(categories[19])
    #   end
    # end
  end

  describe '#show' do
    let(:category) { create(:category) }

    it 'displays the category and its doctor profiles' do
      get :show, params: { id: category.id }
      expect(response).to have_http_status(:ok)
      # expect(assigns(:category)).to eq(category)
      # expect(assigns(:doctor_profiles)).to eq(category.doctor_profiles)
    end
  end
end
