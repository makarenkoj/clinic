class Dictionary < ApplicationRecord
  belongs_to :user
  has_many :words

  validates :name, presence: true, uniqueness: true
  validates :language, presence: true
end
