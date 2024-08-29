class AddFieldsToWatchings < ActiveRecord::Migration[7.0]
  def up
    puts 'UP: add new column'

    add_column :watchings, :continent_code, :string
    add_column :watchings, :continent_name, :string
    add_column :watchings, :country_code2, :string
    add_column :watchings, :country_code3, :string
    add_column :watchings, :country_name, :string
    add_column :watchings, :country_name_official, :string
    add_column :watchings, :country_capital, :string
    add_column :watchings, :state_prov, :string
    add_column :watchings, :state_code, :string
    add_column :watchings, :district, :string
    add_column :watchings, :zipcode, :string
    add_column :watchings, :latitude, :string
    add_column :watchings, :longitude, :string
    add_column :watchings, :is_eu, :string
    add_column :watchings, :calling_code, :string
    add_column :watchings, :country_tld, :string
    add_column :watchings, :languages, :string
    add_column :watchings, :country_flag, :string
    add_column :watchings, :geoname_id, :string
    add_column :watchings, :connection_type, :string
    add_column :watchings, :organization, :string
    add_column :watchings, :country_emoji, :string
    add_column :watchings, :currency, :jsonb
    add_column :watchings, :time_zone, :jsonb

    puts 'UP: update column'

    Watching.all.each do |w|
      w.update(zipcode: w.zip, latitude: w.lat, longitude: w.lon)
    end

    puts 'UP: remove old column'

    remove_column :watchings, :status, :string
    remove_column :watchings, :message, :string
    remove_column :watchings, :country, :string
    remove_column :watchings, :country_code, :string
    remove_column :watchings, :region, :string
    remove_column :watchings, :region_name, :string
    remove_column :watchings, :zip, :string
    remove_column :watchings, :lat, :string
    remove_column :watchings, :lon, :string
    remove_column :watchings, :timezone, :string
    remove_column :watchings, :org, :string
    remove_column :watchings, :as, :string
    remove_column :watchings, :proxy, :string
    remove_column :watchings, :hosting, :string
    remove_column :watchings, :query, :string
  end

  def down
    puts 'DOWN: add old column'

    add_column :watchings, :status, :string
    add_column :watchings, :message, :string
    add_column :watchings, :country, :string
    add_column :watchings, :country_code, :string
    add_column :watchings, :region, :string
    add_column :watchings, :region_name, :string
    add_column :watchings, :zip, :string
    add_column :watchings, :lat, :string
    add_column :watchings, :lon, :string
    add_column :watchings, :timezone, :string
    add_column :watchings, :org, :string
    add_column :watchings, :as, :string
    add_column :watchings, :proxy, :string
    add_column :watchings, :hosting, :string
    add_column :watchings, :query, :string

    puts 'DOWN: update old column'

    Watching.all.each do |w|
      w.update(zip: w.zipcode, lat: w.latitude, lon: w.longitude)
    end

    puts 'DOWN: remove new column'

    remove_column :watchings, :continent_code, :string
    remove_column :watchings, :continent_name, :string
    remove_column :watchings, :country_code2, :string
    remove_column :watchings, :country_code3, :string
    remove_column :watchings, :country_name, :string
    remove_column :watchings, :country_name_official, :string
    remove_column :watchings, :country_capital, :string
    remove_column :watchings, :state_prov, :string
    remove_column :watchings, :state_code, :string
    remove_column :watchings, :district, :string
    remove_column :watchings, :zipcode, :string
    remove_column :watchings, :latitude, :string
    remove_column :watchings, :longitude, :string
    remove_column :watchings, :is_eu, :string
    remove_column :watchings, :calling_code, :string
    remove_column :watchings, :country_tld, :string
    remove_column :watchings, :languages, :string
    remove_column :watchings, :country_flag, :string
    remove_column :watchings, :geoname_id, :string
    remove_column :watchings, :connection_type, :string
    remove_column :watchings, :organization, :string
    remove_column :watchings, :country_emoji, :string
    remove_column :watchings, :currency, :jsonb
    remove_column :watchings, :time_zone, :jsonb
  end
end
