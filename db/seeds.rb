50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
          full_name: name,
          email: email,
          accepted: true,
          password: password)
end

users = User.all
users.each do |user|
  post = user.posts.create(caption: "")
  post.photos.create(image: open("#{Rails.root}/db/fixtures/cat.jpeg"))
end
