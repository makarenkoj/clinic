class DoctorProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_doctor!

  def create
    doctor_profile = current_user.build_doctor_profile

    doctor_profile.save!

    user_url(current_user)
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => _e
    render_json_error(error: format_model_errors(doctor_profile))
  rescue ArgumentError => e
    render_json_error(error: e.message)
  end
end
