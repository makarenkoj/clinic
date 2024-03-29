class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def search
    @results = params[:search].present? ? SearchService.call(search: params[:search][:search]&.downcase) : nil

    render turbo_stream:
      turbo_stream.update('results',
                          partial: 'partials/search',
                          locals: { results: @results })
  end

  def search_categories
    @results = params[:search].present? ? SearchCategoriesService.call(search: params[:search][:search]&.downcase) : nil

    render turbo_stream:
      turbo_stream.update('results',
                          partial: 'partials/categories',
                          locals: { categories: @results })
  end
end
