class Note < ApplicationRecord
  belongs_to :user

  validates :body, :date_time, presence: true

  LIMIT = 10.freeze

  scope :paginate, -> (page:, per_page: LIMIT) {
    page = (page || 1).to_i
    current_scope = limit(per_page).offset((page - 1) * per_page)

    PaginationResultService.new(current_scope).tap do |result|
      result.current_page = page
      result.total_pages = (count / per_page.to_f).ceil
    end
  }
end
