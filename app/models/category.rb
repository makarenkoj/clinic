class Category < ApplicationRecord
  has_many :categories_doctors, dependent: :restrict_with_error
  has_many :doctor_profiles, through: :categories_doctors

  validates :name_en, :name_ua, presence: true

  LOCAL_NAME = { en: 'name_en', ua: 'name_ua' }.freeze

  def local_name
    LOCAL_NAME[I18n.locale]
  end
end
