json.watching do
  json.extract! watching, :ip, :status, :message, :country, :country_code, :region, :region_name, :city, :zip, :lat, :lon, :timezone, :isp, :org, :as, :proxy, :hosting, 
                :query
end
