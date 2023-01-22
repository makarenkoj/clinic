class Category < ApplicationRecord
  has_many :categories_doctors, dependent: :restrict_with_error
  has_many :doctor_profiles, through: :categories_doctors

  local_name_hash = { en: 'name_en', ua: 'name_ua' }

  def local_name
    local_name_hash[I18n.locale]
  end
end
