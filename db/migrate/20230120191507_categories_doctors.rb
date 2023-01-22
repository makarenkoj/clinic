class CategoriesDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :categories_doctors do |t|
      t.references :category, null: false, foreign_key: true
      t.references :doctor_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
