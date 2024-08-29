class CreateWatchings < ActiveRecord::Migration[7.0]
  def change
    create_table :watchings do |t|
      t.string :ip, null: false
      t.string :status
      t.string :message
      t.string :country
      t.string :country_code
      t.string :region
      t.string :region_name
      t.string :city
      t.string :zip
      t.string :lat
      t.string :lon
      t.string :timezone
      t.string :isp
      t.string :org
      t.string :as
      t.string :proxy
      t.string :hosting
      t.string :query
      t.integer :viewing, null: false, default: 1

      t.timestamps
    end
  end
end
