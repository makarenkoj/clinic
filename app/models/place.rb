class Place < ApplicationRecord
  belongs_to :doctor_profile
  validates :name, :location, presence: true
end
