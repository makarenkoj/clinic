class Categories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name_ua
      t.string :name_en

      t.timestamps
    end

    add_index :categories, :name_ua
    add_index :categories, :name_en
  end
end
