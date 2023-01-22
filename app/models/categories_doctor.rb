class CategoriesDoctor < ApplicationRecord
  belongs_to :category
  belongs_to :doctor_profile
end
