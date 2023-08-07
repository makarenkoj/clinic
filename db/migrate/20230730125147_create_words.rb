class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :original, null: false
      t.string :translate, bull: false
      t.string :transcription
      t.references :dictionary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
