# rubocop:disable Metrics/BlockLength
ActiveAdmin.register DoctorProfile do
  actions :all

  index do
    selectable_column
    id_column
    column :username do |doctor_profile|
      doctor_profile.user.username
    end
    column :email do |doctor_profile|
      doctor_profile.user.email
    end 
    column :phone_number do |doctor_profile|
      doctor_profile.user.phone_number
    end 
    column :appointments do |doctor_profile|
      doctor_profile.doctors_appointments.size
    end 
    column :description
    column :created_at

    actions
  end

  show do
    attributes_table do
      row :id
      row :username do |doctor_profile|
        doctor_profile.user.username
      end
      row :email do |doctor_profile|
        doctor_profile.user.email
      end 
      row :phone_number do |doctor_profile|
        doctor_profile.user.phone_number
      end 
      row :description
      row :created_at
      div do
        panel 'doctors appointments', class: 'appointments-container' do  
          h4 class: 'no-appointments' do
            'No appointments' if doctor_profile.doctors_appointments.blank?
          end

          doctor_profile.doctors_appointments.each do |da|
            div class: 'appointments' do
              "date time: #{date_format(da.visit_time)} /doctor: #{da.doctor_profile.user.username} /description: #{da.description}"
            end
          end
        end
      end
    end
  end

  filter :user_email, as: :string
  filter :user_username, as: :string
  filter :user_phone_number, as: :numeric
end
# rubocop:enable Metrics/BlockLength
