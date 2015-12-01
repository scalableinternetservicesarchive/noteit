
Note.delete_all
User.delete_all
Notebook.delete_all
Comment.delete_all
Relationship.delete_all

num_users = 0
num_notes = 0
num_notebooks = 0
num_comments = 0
num_user_notes = 0
if Rails.env == 'production'
  num_users = 10000
  num_notes = 10000
  num_notebooks = 15
  num_user_notes = 150
  num_comments = 10000
else
  num_users = 100
  num_notes = 50
  num_comments = 60
  num_notebooks = 5
  num_user_notes = 15
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

num_user_notes.times do
  inserts = []
  inserts << "'#{Faker::Hacker.adjective}', '#{user.id}', '#{Faker::Date.between(3.days.ago, Date.today)}', '#{Faker::Date.between(2.days.ago, Date.today)}', '#{Faker::Lorem.sentence(5)}', '#{(Faker::Team.state)}', '#{(Faker::Team.creature)}', '#{Faker::Lorem.word}', '#{rand(1..num_notebooks)}'"
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

num_user_notes.times do
  inserts = []
  inserts << "'#{Faker::Hacker.adjective}', '#{user.id}', '#{Faker::Date.between(3.days.ago, Date.today)}', '#{Faker::Date.between(2.days.ago, Date.today)}', '#{Faker::Lorem.sentence(5)}', '#{(Faker::Team.state)}', '#{(Faker::Team.creature)}', '#{Faker::Lorem.word}', '#{rand(1..num_notebooks)}'"
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
  note_id = rand(1..num_notes)
  user = rand(1..num_users)
  inserts = []
  inserts << "'#{Faker::Lorem.sentence(1)}', '#{user}', '#{Faker::Date.between(3.days.ago, Date.today)}', '#{Faker::Date.between(2.days.ago, Date.today)}', '#{note_id}'"
  sql = "INSERT INTO comments (content, user_id, created_at, updated_at, note_id) VALUES (#{inserts.join(", ")})"
  connection.execute(sql)
end
