FactoryBot.define do
  factory :watching do
    ip { Faker::Internet.public_ip_v4_address }
    status { 'success' }
    message { nil }
    country { 'Italy' }
    country_code { 'IT' }
    region { '25' }
    region_name { 'Lombardy' }
    city { 'Milano' }
    zip { '' }
    lat { '45.4642' }
    lon { '9.1899' }
    timezone { 'Europe/Rome' }
    isp { 'Iliad Italia' }
    org { 'Iliad Italia S.p.A' }
    as { 'AS29447 SCALEWAY S.A.S.' }
    proxy { 'f' }
    hosting { 'f' }
    query { Faker::Internet.public_ip_v4_address }
    viewing { 4 }
  end
end
