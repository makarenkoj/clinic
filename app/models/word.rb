class Word < ApplicationRecord
  belongs_to :dictionary

  validates :original, :translate, presence: true
end
