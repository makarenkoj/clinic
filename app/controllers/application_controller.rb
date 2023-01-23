class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  around_action :switch_locale

  def check_doctor!
    return if current_user&.doctor?

    redirect_to root_path, notice: t('errors.doctor_only')
  end

  def check_patient!
    return if current_user&.patient?

    redirect_to root_path, notice: t('errors.patient_only')
  end

  def after_sign_in_path_for(resource)
    case resource[:type]
    when User::DOCTOR
      doctor_profile_url(resource&.doctor_profile)
    when User::PATIENT
      patient_profile_url(resource&.patient_profile)
    else
      super
    end
  end

  private

  def switch_locale(&action)
    locale = locale_from_url || I18n.default_locale
    I18n.with_locale locale, &action
  end

  def locale_from_url
    parsed_locale = params[:locale]
    parsed_locale.to_sym if I18n.available_locales.map(&:to_s).include?(parsed_locale)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def render_not_found(error)
    render_error error: t('activerecord.errors.messages.record_not_found'),
                 data: {
                   id: error&.id,
                   model: error&.model,
                   primary_key: error&.primary_key
                 },
                 status: 404
  end

  def render_error(error: t('errors.messages.bad_request'), data: nil, status: 400)
    render json: { error: error, data: data }, status: status
  end

  def configure_permitted_parameters
    added_attrs = %i[type username phone_number email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
