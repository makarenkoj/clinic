# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def new_name
  name = Faker::Games::Heroes.name.downcase
  if name.size <= 4
    new_name
  else
    name
  end
end

password = '123456'
puts 'Create admin'

AdminUser.create!(email: 'admin@example.com', password: password, password_confirmation: password) if Rails.env.development?

puts 'Creating category'

category = [{:Cardiologist=>"Кардіолог"},
  {:Physicians=>"Цілитель"},
  {:"Emergency Medicine"=>"Невідкладна медицина"},
  {:Endocrinologist=>"Ендокринолог"},
  {:Gastroenterologist=>"Гастроентеролог"},
  {:Oncologist=>"Онколог"},
  {:Internist=>"Інтерніст"},
  {:Ophthalmologist=>"Лікар-офтальмолог"},
  {:Radiologist=>"Рентгенолог"},
  {:Nephrologist=>"Нефролог"},
  {:Allergist=>"Алерголог"},
  {:Anesthesiologist=>"Анестезіолог"},
  {:Geriatrician=>"Геріатр"},
  {:Pathology=>"Патологія"},
  {:"General practitioner"=>"Лікар загальної практики"},
  {:"Infectious Disease Specialist"=>"Лікар-інфекціоніст"},
  {:Orthopedist=>"Ортопед"},
  {:Otolaryngologist=>"Отоларинголог"},
  {:Pulmonologist=>"Пульмонолог"}]

category.each { |cat| Category.create!(name_ua: "#{cat.values[0]}", name_en: "#{cat.keys[0].to_s}") }

if Rails.env.development?
  puts 'Creating doctor'

  10.times do |i|
    doctor = User.create!(email: "#{Faker::GreekPhilosophers.name}#{i}@mail.com",
                          phone_number: "+38066784558#{i}", 
                          username:  new_name, 
                          type: User::DOCTOR, 
                          password: password, password_confirmation: password)
    doctor.doctor_profile.categories << Category.all[i]
  end

  puts 'Creating patient'

  10.times do |i|
    User.create!(email: "#{Faker::GreekPhilosophers.name}#{i}@mail.com", phone_number: "+3806678455#{i}9", username: new_name, type: User::PATIENT, password: password, password_confirmation: password)
  end
end
