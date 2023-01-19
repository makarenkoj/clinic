class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def check_doctor!
    return if current_user&.doctor?

    render_json_error(error: I18n.t('errors.doctor_only'), status: 403)
  end

  private

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
    added_attrs = %i[username phone_number email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
