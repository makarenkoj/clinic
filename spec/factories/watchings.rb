FactoryBot.define do
  factory :watching do
    ip { Faker::Internet.public_ip_v4_address }
    continent_code { 'EU' }
    continent_name { 'Europe' }
    country_code2 { 'IT' }
    country_code3 { 'ITA' }
    country_name { 'Italy' }
    country_name_official { 'Republic of Italy' }
    country_capital { 'Rome' }
    state_prov { 'Lombardy' }
    state_code { 'IT-25' }
    district { 'test' }
    city { 'Milan' }
    zipcode { '20145' }
    latitude { '45.47897' }
    longitude { '9.16516' }
    is_eu { true }
    calling_code { '+39' }
    country_tld { '.it' }
    languages { 'it-IT,de-IT,fr-IT,sc,ca,co,sl' }
    country_flag { 'https://ipgeolocation.io/static/flags/it_64.png' }
    geoname_id { '6519349' }
    isp { 'Iliad Italia' }
    connection_type { 'test' }
    organization { 'SCALEWAY S.A.S.' }
    country_emoji { '🇮🇹' }
    currency { { code: 'EUR', name: 'Euro', symbol: '€' } }
    time_zone do
      { name: 'Europe/Rome', 
        offset: 1, 
        offset_with_dst: 2,
        current_time: '2024-08-29 22:08:24.586+0200', 
        current_time_unix: 1_724_962_104.586,
        is_dst: true,
        dst_savings: 1,
        dst_exists: true, 
        dst_start: { utc_time: '2024-03-31 TIME 01',
                     duration: '+1H',
                     gap: true,
                     date_time_after: '2024-03-31 TIME 03',
                     date_time_before: '2024-03-31 TIME 02',
                     overlap: false }, 
        dst_end: { utc_time: '2024-10-27 TIME 01',
                   duration: '-1H',
                   gap: false,
                   date_time_after: '2024-10-27 TIME 02',
                   date_time_before: '2024-10-27 TIME 03',
                   overlap: true } }
    end
    viewing { 4 }
  end
end
