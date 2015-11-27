connection = ActiveRecord::Base.connection

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

15.times do
  title = Faker::Book.title
  sql = "INSERT INTO `notebooks` (`title`, `user_id`, `created_at`, `updated_at`) VALUES ('#{title}', '#{user.id}', '2015-11-27 05:37:11', '2015-11-27 05:37:11')"
  connection.execute(sql)
  #user.notebooks.create!(title: title) 
end

100.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Hacker.adjective
  university = Faker::University.name 
  class_subject = Faker::Lorem.word
  professor = Faker::Name.name
  notebook = user.notebooks.last.id
  sql = "INSERT INTO `notes` (`title`, `user_id`, `created_at`, `updated_at`, 'content', 'university', 'professor', 'class_subject','notebook_id') VALUES ('#{title}', '#{user.id}', '2015-11-27 05:37:11', '2015-11-27 05:37:11', '#{content}','#{university}','#{professor}','#{class_subject}','#{notebook}')"
  connection.execute(sql)
  #user.notes.create!(title: title, content: content, notebook_id: notebook, university: university, class_subject: class_subject, professor: professor) 

end

user = User.find_by(name: 'Aviral')

15.times do
  title = Faker::Book.title
  user.notebooks.create!(title: title) 
end

100.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Hacker.adjective
  university = Faker::University.name 
  class_subject = Faker::Lorem.word
  professor = Faker::Name.name
  notebook = user.notebooks.last.id
  sql = "INSERT INTO `notes` (`title`, `user_id`, `created_at`, `updated_at`, 'content', 'university', 'professor', 'class_subject','notebook_id') VALUES ('#{title}', '#{user.id}', '2015-11-27 05:37:11', '2015-11-27 05:37:11', '#{content}','#{university}','#{professor}','#{class_subject}','#{notebook}')"
  connection.execute(sql)
  
  #user.notes.create!(title: title, content: content, notebook_id: notebook, university: university, class_subject: class_subject, professor: professor) 
end


# Following relationships
users = User.all
user  = users.first
following = users[200..500]
followers = users[300..400]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) } 

user  = users.second
following = users[6..40]
followers = users[4..90]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) } 


#create notes
10000.times do
  user = User.find(rand(1..10000)) #find a random user

  #create note
  content = Faker::Lorem.sentence(5)
  title = Faker::Hacker.adjective
  university = Faker::University.name 
  class_subject = Faker::Lorem.word
  professor = Faker::Name.name
  sql = "INSERT INTO `notes` (`title`, `user_id`, `created_at`, `updated_at`, 'content', 'university', 'professor', 'class_subject') VALUES ('#{title}', '#{user.id}', '2015-11-27 05:37:11', '2015-11-27 05:37:11', '#{content}','#{university}','#{professor}','#{class_subject}')"
  connection.execute(sql)
  
  #user.notes.create!(title: title, content: content, university: university, class_subject: class_subject, professor: professor) 
end 
