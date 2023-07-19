require 'rails_helper'

# rspec spec/services/search_categories_service_spec.rb

describe SearchCategoriesService do
  let(:category) { create(:category, name_en: 'category1') }
  let(:categories) { create_list(:category, 5) }

  before do
    category
    categories
  end

  it 'should return category' do
    expect(SearchCategoriesService.call(search: category.name_en).size).to eql 1
    expect(SearchCategoriesService.call(search: category.name_ua)[0].name_en).to eql category.name_en
    expect(SearchCategoriesService.call(search: Category.second.name_ua).size).to eql 1
    expect(SearchCategoriesService.call(search: Category.second.name_ua)[0].name_en).to eql Category.second.name_en
  end
end
