class User < ApplicationRecord
  attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  self.inheritance_column = nil

  USERNAME_REGEXP = /\A[a-z\d](?:[a-z\d]|-(?=[a-z\d])){0,38}\z/i

  DOCTOR = 'doctor'.freeze
  PATIENT = 'patient'.freeze

  TYPES = {
    DOCTOR => DOCTOR,
    PATIENT => PATIENT
  }.freeze

  has_one :doctor_profile, dependent: :destroy
  has_one :patient_profile, dependent: :destroy

  has_one_attached :image
  has_many_attached :pictures

  has_many :pixels
  has_many :dictionaries

  enum type: TYPES

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: Devise.email_regexp }
  validates :username, presence: true,
                       length: { minimum: 4, maximum: 20 },
                       uniqueness: true,
                       format: {
                         with: User::USERNAME_REGEXP,
                         message: :invalid_slug
                       }
  validates :phone_number, phone: true, presence: true
  validates :type, inclusion: { in: types.keys, message: I18n.t('activerecord.errors.models.user.attributes.type') }

  before_create :username_downcase
  after_create :create_profile

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value OR lower(phone_number) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email) || conditions.key?(:phone_number)
      where(conditions.to_h).first
    end
  end

  # rubocop:disable Naming/AccessorMethodName
  def get_last_pixel_color
    # guard clause, return white if no pixels
    return 'white' if pixels.empty?

    pixels.last.color 
  end
  # rubocop:enable Naming/AccessorMethodName

  private

  def username_downcase
    return unless username.present?

    username.downcase!
  end

  def create_profile
    if doctor?
      DoctorProfile.create!(user: self)
    else
      PatientProfile.create!(user: self)
    end
  end
end
