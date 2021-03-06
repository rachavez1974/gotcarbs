# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Create a main sample user.
User.create!(first_name:  "Ramon",
             last_name: "Chavez",
             email: "razor@gmail.org",
             password:              "123",
             password_confirmation: "123",
             terms: true,
             email_list: true,
             birthday: nil,
             admin: true,
             phone_number: "2403508067",
             :addresses_attributes => [  street_address: "Weework St",
                                         number: "CS200",
                                         city: "Silicon Valley",
                                         zipcode: "20018",
                                         state: "California",
                                         address_type: 0,
                                         unit_type: 1 ])

# # Generate a bunch of additional users with one address
10.times do |n|
  name = Faker::Name.name.split(" ")
  first_name = name[0]
  last_name  = name[1]
  email = "example-#{n+1}@gotcarbs.org"
  password = "password"
  password_confirmation = "password"
  terms = true
  email_list = Faker::Boolean.boolean
  birthday = Faker::Date.between(from: 99.years.ago, to: Date.today)
  phone_number = Faker::Number.number(digits: 10)

  st = Faker::Address.street_address
  num = Faker::Address.building_number
  city = Faker::Address.city_prefix
  code = Faker::Address.zip.slice(0, 5)
  state = Faker::Address.state
  ad_type = rand(0..3)
  u_type = rand(0..3)

  User.create!(first_name:  first_name,
               last_name: last_name,
               email: email,
               password:              password,
               password_confirmation: password_confirmation,
               terms: terms,
               email_list: email_list,
               birthday: birthday,
               phone_number: phone_number,
               :addresses_attributes => [street_address: st,
                                         number: num,
                                         city: city,
                                         zipcode: code,
                                         state: state,
                                         address_type: ad_type,
                                         unit_type: u_type])
end

#create all menu items
165.times do |n|
  #doing this twice because rand is giving same number
  array_menu = Array.new(6) { rand(0..5) }
  menu = array_menu[rand(0..5)]
  array_menu = Array.new(5) { rand(0..4) }
  section = array_menu[rand(0..4)]
  
  name = Faker::Food.dish
  desc = Faker::Food.description
  price = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  av = true

  Item.create!(name: name,
               description: desc,
               price: price,
               menu_type: menu,
               section: section,
               availability: av)

end

#create orders for users
users = User.all
  users.each do |user|
    5.times do |n|
      order = user.orders.new
      3.times do |n|
        item_id =rand(1..100)
        item_quantity = rand(1..3)
        order.ordered_items.new(:quantity => item_quantity, :item_id => item_id)
        date = Faker::Date.between(from: 1.year.ago, to: Date.today)
        order.save
        order.update_attributes(:created_at => date)
      end
    end
  end