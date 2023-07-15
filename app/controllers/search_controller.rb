class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def search
    @results = SearchService.call(search: params[:search]&.downcase)

    render turbo_stream:
      turbo_stream.update('results',
                          partial: 'partials/search',
                          locals: { results: @results })
  end
end
