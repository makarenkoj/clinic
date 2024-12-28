class CreateJsPayloads < ActiveRecord::Migration[7.0]
  def change
    create_table :js_payloads do |t|
      t.json :payload

      t.timestamps
    end
  end
end
