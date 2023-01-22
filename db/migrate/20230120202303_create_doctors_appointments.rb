class CreateDoctorsAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors_appointments do |t|
      t.references :doctor_profile, null: false, foreign_key: true
      t.references :patient_profile, null: false, foreign_key: true
      t.datetime :visit_time
      t.text :description

      t.timestamps
    end
  end
end
