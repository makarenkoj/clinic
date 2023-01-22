class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if resource.doctor?
      edit_doctor_profile_url(resource.doctor_profile)
    else
      edit_patient_profile_url(resource.patient_profile)
    end
  end
end
