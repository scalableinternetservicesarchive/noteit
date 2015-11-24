User.create!(name:  "Note It User",
             email: "niu@gmail.com",
             password: "12345678",
             )

User.create!(name:  "Aviral",
             email: "aviral@gmail.com",
             password: "12345678",
             )

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+3}@cs290b.org"
  password = "password"   
  User.create!(name:  name,
               email: email,
               password: password
               )
end
user = User.find_by(name: 'Note It User')

50.times do
  title = Faker::Lorem.sentence(1)
  user.notebooks.create!(title: title) 
end

10.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.sentence(1)
  notebook = Notebook.find_by(id: 1)
  user.notes.create!(title: title, content: content, notebook_id: notebook.id) 
end

user = User.find_by(name: 'Aviral')

50.times do
  title = Faker::Lorem.sentence(1)
  user.notebooks.create!(title: title) 
end

10.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.sentence(1)
  notebook = Notebook.find_by(id: 1)
  user.notes.create!(title: title, content: content, notebook_id: notebook.id) 
end


# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) } 

user  = users.second
following = users[3..50]
followers = users[4..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) } 


#create notes
100.times do
  user = User.find(rand(1..101)) #find a random user

  #create note
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.sentence(1)
  user.notes.create!(title: title, content: content)
end 
