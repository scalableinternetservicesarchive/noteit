
Note.delete_all
User.delete_all
Notebook.delete_all
Comment.delete_all
Relationship.delete_all

num_users = 0
num_notes = 0
num_notebooks = 0
num_comments = 0

if Rails.env == 'production'
  num_users = 10000
  num_notes = 10000
  num_notebooks = 150
  num_comments = 10000
else
  num_users = 100
  num_notes = 50
  num_comments = 60
  num_notebooks = 15
end

connection = ActiveRecord::Base.connection

Note.skip_callback(:create)
User.skip_callback(:create)
Notebook.skip_callback(:create)
Relationship.skip_callback(:create)
Comment.skip_callback(:create)

User.create!(name:  "Note It User",
             email: "niu@gmail.com",
             password: "12345678",
             )

User.create!(name:  "Aviral",
             email: "aviral@gmail.com",
             password: "12345678",
             )

begin_time = Time.now

pwd  = User.new.send(:password_digest, '12345678')

num_users.times do |n|
  inserts = []
  inserts << "'#{Faker::Team.creature}', 'example-#{n+3}@cs290b.org', '#{pwd}', '#{Faker::Date.between(3.days.ago, Date.today)}', '#{Faker::Date.between(2.days.ago, Date.today)}'"
  sql = "INSERT INTO users (name, email, encrypted_password, created_at, updated_at) VALUES (#{inserts.join(", ")})"
  connection.execute sql
end

users = User.all
#test user 1
user = User.find_by(name: 'Note It User')

num_notebooks.times do
  inserts = []
  inserts << "'#{(Faker::Book.title)}', '#{user.id}', '#{Faker::Date.between(3.days.ago, Date.today)}', '#{Faker::Date.between(2.days.ago, Date.today)}'"
  sql = "INSERT INTO notebooks (title, user_id, created_at, updated_at) VALUES (#{inserts.join(", ")})"
  connection.execute(sql)
end

num_notes.times do
  inserts = []
  inserts << "'#{Faker::Hacker.adjective}', '#{user.id}', '#{Faker::Date.between(3.days.ago, Date.today)}', '#{Faker::Date.between(2.days.ago, Date.today)}', '#{Faker::Lorem.sentence(5)}', '#{(Faker::Team.state)}', '#{(Faker::Team.creature)}', '#{Faker::Lorem.word}', '#{user.notebooks.last.id}'"
  sql = "INSERT INTO notes (title, user_id, created_at, updated_at, content, university, professor, class_subject, notebook_id) VALUES (#{inserts.join(", ")})"
  connection.execute(sql)
end

following = users[6..78]
followers = users[4..99]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) } 

#test user 2
user = User.find_by(name: 'Aviral')

num_notebooks.times do
  inserts = []
  inserts << "'#{(Faker::Book.title)}', '#{user.id}', '#{Faker::Date.between(3.days.ago, Date.today)}', '#{Faker::Date.between(2.days.ago, Date.today)}'"
  sql = "INSERT INTO notebooks (title, user_id, created_at, updated_at) VALUES (#{inserts.join(", ")})"
  connection.execute(sql)
end

num_notes.times do
  inserts = []
  inserts << "'#{Faker::Hacker.adjective}', '#{user.id}', '#{Faker::Date.between(3.days.ago, Date.today)}', '#{Faker::Date.between(2.days.ago, Date.today)}', '#{Faker::Lorem.sentence(5)}', '#{(Faker::Team.state)}', '#{(Faker::Team.creature)}', '#{Faker::Lorem.word}', '#{user.notebooks.last.id}'"
  sql = "INSERT INTO notes (title, user_id, created_at, updated_at, content, university, professor, class_subject, notebook_id) VALUES (#{inserts.join(", ")})"
  connection.execute(sql)
end

following = users[(num_users/3)..(num_users/2)]
followers = users[(num_users/5)..(num_users/4)]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) } 


#create notes
num_notes.times do
  user = rand((User.first.id)..(User.last.id)) #find a random user

  #create note
  inserts = []
  inserts << "'#{Faker::Hacker.adjective}', '#{user}', '#{Faker::Date.between(3.days.ago, Date.today)}', '#{Faker::Date.between(2.days.ago, Date.today)}', '#{Faker::Lorem.sentence(5)}', '#{(Faker::Team.state)}', '#{(Faker::Team.creature)}', '#{Faker::Lorem.word}'"
  sql = "INSERT INTO notes (title, user_id, created_at, updated_at, content, university, professor, class_subject) VALUES (#{inserts.join(", ")})"
  connection.execute(sql)
end 

#create comments
num_comments.times do
  note_id = rand((Note.first.id)..(Note.last.id))
  user = rand((User.first.id)..(User.last.id))
  inserts = []
  inserts << "'#{Faker::Lorem.sentence(1)}', '#{user}', '#{Faker::Date.between(3.days.ago, Date.today)}', '#{Faker::Date.between(2.days.ago, Date.today)}', '#{note_id}'"
  sql = "INSERT INTO comments (content, user_id, created_at, updated_at, note_id) VALUES (#{inserts.join(", ")})"
  connection.execute(sql)
end


# # Following relationships
# users = User.all
# user  = users.first
# following = users[200..500]
# followers = users[300..400]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) } 

# user  = users.second


# connection = ActiveRecord::Base.connection

# 9999.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+3}@cs290b.org"
#   password = "password" 

#   User.create!(name:  name,
#                email: email,
#                password: password
#                )
# end


# User.create!(name:  "Note It User",
#              email: "niu@gmail.com",
#              password: "12345678",
#              )

# User.create!(name:  "Aviral",
#              email: "aviral@gmail.com",
#              password: "12345678",
#              )


# user = User.find_by(name: 'Note It User')

# 15.times do
#   title = Faker::Book.title
#   sql = "INSERT INTO `notebooks` (`title`, `user_id`, `created_at`, `updated_at`) VALUES ('#{title}', '#{user.id}', '2015-11-27 05:37:11', '2015-11-27 05:37:11')"
#   connection.execute(sql)
#   #user.notebooks.create!(title: title) 
# end

# 100.times do
#   content = Faker::Lorem.sentence(5)
#   title = Faker::Hacker.adjective
#   university = Faker::University.name 
#   class_subject = Faker::Lorem.word
#   professor = Faker::Name.name
#   notebook = user.notebooks.last.id
#   sql = "INSERT INTO `notes` (`title`, `user_id`, `created_at`, `updated_at`, 'content', 'university', 'professor', 'class_subject','notebook_id') VALUES ('#{title}', '#{user.id}', '2015-11-27 05:37:11', '2015-11-27 05:37:11', '#{content}','#{university}','#{professor}','#{class_subject}','#{notebook}')"
#   connection.execute(sql)
#   #user.notes.create!(title: title, content: content, notebook_id: notebook, university: university, class_subject: class_subject, professor: professor) 

# end

# user = User.find_by(name: 'Aviral')

# 15.times do
#   title = Faker::Book.title
#   user.notebooks.create!(title: title) 
# end

# 100.times do
#   content = Faker::Lorem.sentence(5)
#   title = Faker::Hacker.adjective
#   university = Faker::University.name 
#   class_subject = Faker::Lorem.word
#   professor = Faker::Name.name
#   notebook = user.notebooks.last.id
#   sql = "INSERT INTO `notes` (`title`, `user_id`, `created_at`, `updated_at`, 'content', 'university', 'professor', 'class_subject','notebook_id') VALUES ('#{title}', '#{user.id}', '2015-11-27 05:37:11', '2015-11-27 05:37:11', '#{content}','#{university}','#{professor}','#{class_subject}','#{notebook}')"
#   connection.execute(sql)
  
#   #user.notes.create!(title: title, content: content, notebook_id: notebook, university: university, class_subject: class_subject, professor: professor) 
# end


# # Following relationships
# users = User.all
# user  = users.first
# following = users[200..500]
# followers = users[300..400]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) } 

# user  = users.second
# following = users[6..40]
# followers = users[4..90]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) } 


# #create notes
# 10000.times do
#   user = User.find(rand(1..10000)) #find a random user

#   #create note
#   content = Faker::Lorem.sentence(5)
#   title = Faker::Hacker.adjective
#   university = Faker::University.name 
#   class_subject = Faker::Lorem.word
#   professor = Faker::Name.name
#   sql = "INSERT INTO `notes` (`title`, `user_id`, `created_at`, `updated_at`, 'content', 'university', 'professor', 'class_subject') VALUES ('#{title}', '#{user.id}', '2015-11-27 05:37:11', '2015-11-27 05:37:11', '#{content}','#{university}','#{professor}','#{class_subject}')"
#   connection.execute(sql)
  
#   #user.notes.create!(title: title, content: content, university: university, class_subject: class_subject, professor: professor) 
# end 
