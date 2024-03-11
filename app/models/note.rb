class Note < ApplicationRecord
  belongs_to :user

  validates :body, :date_time, presence: true
end
