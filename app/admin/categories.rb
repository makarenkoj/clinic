# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Category do
  actions :all

  index do
    selectable_column
    id_column
    column :name_en
    column :name_ua
    column :doctor_profiles do |category|
      category.doctor_profiles.size
    end
    column :created_at
    actions
  end

  filter :name_en, as: :string
  filter :name_ua, as: :string

  show do
    attributes_table do
      row :id
      row :name_en
      row :name_ua
      row :created_at
      div do
        panel 'doctors appointments', class: 'appointments-container' do  
          h4 class: 'no-appointments' do
            'No doctors' if category.doctor_profiles.blank?
          end

          category.doctor_profiles.each do |doctor|
            div class: 'appointments' do
              "username: #{doctor.user.username} /email: #{doctor.user.email} /phone_number: #{doctor.user.phone_number}"
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
