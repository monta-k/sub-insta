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

User.create!(name: "サンプルユーザー",
        full_name: "サンプルユーザー",
        email: "sample@email.com",
        accepted: true,
        password: password)

User.create!(name: "サンプルユーザー2",
        full_name: "サンプルユーザー2",
        email: "sample2@email.com",
        accepted: true,
        password: password)


users = User.all
users.each do |user|
  post1 = user.posts.create(caption: "ネコ")
  post1.photos.create(image: open("#{Rails.root}/db/fixtures/cat.jpeg"))

  post2 = user.posts.create(caption: "ネコ２")
  post2.photos.create(image: open("#{Rails.root}/db/fixtures/cat2.jpeg"))

  post3 = user.posts.create(caption: "シマウマ")
  post3.photos.create(image: open("#{Rails.root}/db/fixtures/hourse.jpeg"))

  post1 = user.posts.create(caption: "イヌ")
  post1.photos.create(image: open("#{Rails.root}/db/fixtures/dog.jpeg"))

  post1 = user.posts.create(caption: "ハリネズミ")
  post1.photos.create(image: open("#{Rails.root}/db/fixtures/mouse.jpeg"))

  post1 = user.posts.create(caption: "ライオン")
  post1.photos.create(image: open("#{Rails.root}/db/fixtures/lion.jpeg"))
end
