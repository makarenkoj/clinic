class CreateDoctorProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :doctor_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
