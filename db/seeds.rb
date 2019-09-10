# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Create a main sample user.
# User.create!(first_name:  "Ramon",
#              last_name: "Chavez"
#              email: "razor@gmail.org",
#              password:              "123",
#              password_confirmation: "123",
#              terms: true,
#              email_list: true,
#              birthday: nil,
#              phone_number: "2403508067"
#              )

# Generate a bunch of additional users.
30.times do |n|
  name = Faker::Name.name.split(" ")
  first_name = name[0]
  last_name  = name[1]
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  password_confirmation = "password"
  terms = true
  email_list = Faker::Boolean.boolean
  birthday = Faker::Date.between(from: 99.years.ago, to: Date.today)
  phone_number = Faker::Number.number(digits: 10)


  User.create!(first_name:  first_name,
               last_name: last_name,
               email: email,
               password:              password,
               password_confirmation: password_confirmation,
               terms: terms,
               email_list: email_list,
               birthday: birthday,
               phone_number: phone_number)
end