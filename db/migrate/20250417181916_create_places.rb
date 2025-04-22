class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.references :doctor_profile, null: false, foreign_key: true
      t.string :name, null: false
      t.string :location, null: false
      t.decimal :x
      t.decimal :y

      t.timestamps
    end
  end
end
