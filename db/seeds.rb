# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Note It User",
             email: "niu@gmail.com",
             password: "12345678",
             )

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"	  
  User.create!(name:  name,
               email: email,
               password: password
               )
end
user = User.find_by(name: 'Note It User')
50.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.sentence(1)
  user.notes.create!(title: title, content: content) 
end