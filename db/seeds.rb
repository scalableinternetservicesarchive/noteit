
User.create!(name:  "Note It User",
             email: "niu@gmail.com",
             password: "12345678",
             )

10000.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"	  
  User.create!(name:  name,
               email: email,
               password: password
               )
end
user = User.find_by(name: 'Note It User')
r = Random.new
50.times do
  title = Faker::Lorem.sentence(1)
  user.notebooks.create!(title: title) if user
end

1000.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.sentence(1)
  notebook = Notebook.find_by(id: 1)
  user.notes.create!(title: title, content: content, notebook_id: notebook.id) if user
end

