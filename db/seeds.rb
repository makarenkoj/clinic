# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
password = '123456'
puts 'Create admin'

# AdminUser.create!(email: 'admin@example.com', password: password, password_confirmation: password) if Rails.env.development?

if Rails.env.development?
  puts 'Creating category'

  10.times do |_i|
    Category.create!(name_ua: Faker::Job.title, name_en: Faker::Job.seniority)
  end

  puts 'Creating doctor'

  10.times do |i|
    User.create!(email: "#{Faker::GreekPhilosophers.name}#{i}@mail.com", phone_number: "+38066784558#{i}", username: Faker::Games::Heroes.name, type: User::DOCTOR, password: password, password_confirmation: password)
  end

  puts 'Creating patient'

  10.times do |i|
    User.create!(email: "#{Faker::GreekPhilosophers.name}#{i}@mail.com", phone_number: "+3806678455#{i}9", username: Faker::Games::Heroes.name, type: User::PATIENT, password: password, password_confirmation: password)
  end
end
