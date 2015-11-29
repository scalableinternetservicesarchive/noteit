
9999.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+3}@cs290b.org"
  password = "password"   
  User.create!(name:  name,
               email: email,
               password: password
               )
end


User.create!(name:  "Note It User",
             email: "niu@gmail.com",
             password: "12345678",
             )

User.create!(name:  "Aviral",
             email: "aviral@gmail.com",
             password: "12345678",
             )


user = User.find_by(name: 'Note It User')

50.times do
  title = Faker::Lorem.sentence(1)
  user.notebooks.create!(title: title) 
end

10.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.sentence(1)
  university = Faker::Lorem.sentence(2)
  class_subject = Faker::Lorem.sentence(2)
  professor = Faker::Lorem.sentence(2)
  notebook = user.notebooks.first.id
  user.notes.create!(title: title, content: content, notebook_id: notebook.id, university: university, class_subject: class_subject, professor: professor) 

end

user = User.find_by(name: 'Aviral')

50.times do
  title = Faker::Lorem.sentence(1)
  user.notebooks.create!(title: title) 
end

10.times do
  content = Faker::Lorem.sentence(50)
  title = Faker::Lorem.sentence(2)
  university = Faker::Lorem.sentence(2)
  class_subject = Faker::Lorem.sentence(2)
  professor = Faker::Lorem.sentence(2)
  notebook = user.notebooks.first.id
  user.notes.create!(title: title, content: content, notebook_id: notebook.id, university: university, class_subject: class_subject, professor: professor) 
end


# Following relationships
users = User.all
user  = users.first
following = users[2..500]
followers = users[3..400]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) } 

user  = users.second
following = users[3..500]
followers = users[4..400]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) } 


#create notes
100000.times do
  user = User.find(rand(1..10000)) #find a random user

  #create note
  content = Faker::Lorem.sentence(50)
  title = Faker::Lorem.sentence(2)
  university = Faker::Lorem.sentence(2)
  class_subject = Faker::Lorem.sentence(2)
  professor = Faker::Lorem.sentence(2)
  user.notes.create!(title: title, content: content, university: university, class_subject: class_subject, professor: professor) 
end 
