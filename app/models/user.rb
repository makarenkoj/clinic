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

  enum type: TYPES

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: Devise.email_regexp }
  validates :username, presence: true,
                       length: { minimum: 4, maximum: 50 },
                       uniqueness: true,
                       format: {
                         with: User::USERNAME_REGEXP,
                         message: :invalid_slug
                       }
  validates :phone_number, phone: true, presence: true
  validates :type, inclusion: { in: types.keys, message: I18n.t('activerecord.errors.models.user.attributes.type') }

  after_create :create_profile

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value OR lower(phone_number) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email) || conditions.key?(:phone_number)
      where(conditions.to_h).first
    end
  end

  private

  def create_profile
    if doctor?
      DoctorProfile.create!(user: self)
    else
      PatientProfile.create!(user: self)
    end
  end
end
