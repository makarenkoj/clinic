ActiveAdmin.register DoctorsAppointment do
  actions :all

  index do
    selectable_column
    id_column
    column :doctor do |doctors_appointment|
      doctors_appointment.doctor_profile.user.username
    end
    column :patient do |doctors_appointment|
      doctors_appointment.patient_profile.user.username
    end
    column :description
    column :created_at
    actions
  end

  filter :doctor_profile_user_email, as: :string
  filter :doctor_profile_user_username, as: :string
  filter :patient_profile_user_email, as: :string
  filter :patient_profile_user_username, as: :string

  show do
    attributes_table do
      row :id
      column :doctor do |doctors_appointment|
        doctors_appointment.doctor_profile.user.username
      end
      column :patient do |doctors_appointment|
        doctors_appointment.patient_profile.user.username
      end
      row :description
      row :created_at
    end
  end
end
