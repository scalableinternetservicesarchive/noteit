
99.times do |n|
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

15.times do
  title = Faker::Book.title
  user.notebooks.create!(title: title) 
end

10.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Hacker.adjective
  university = Faker::University.name 
  class_subject = Faker::Lorem.word
  professor = Faker::Name.name
  notebook = user.notebooks.last.id
  user.notes.create!(title: title, content: content, notebook_id: notebook, university: university, class_subject: class_subject, professor: professor) 

end

user = User.find_by(name: 'Aviral')

15.times do
  title = Faker::Book.title
  user.notebooks.create!(title: title) 
end

10.times do
  content = Faker::Lorem.sentence(50)
  title = Faker::Hacker.adjective
  university = Faker::University.name 
  class_subject = Faker::Lorem.word
  professor = Faker::Name.name
  notebook = user.notebooks.last.id
  user.notes.create!(title: title, content: content, notebook_id: notebook, university: university, class_subject: class_subject, professor: professor) 
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
  user = User.find(rand(1..100)) #find a random user

  #create note
  content = Faker::Lorem.sentence(50)
  title = Faker::Hacker.adjective
  university = Faker::University.name 
  class_subject = Faker::Lorem.word
  professor = Faker::Name.name
  user.notes.create!(title: title, content: content, university: university, class_subject: class_subject, professor: professor) 
end 
