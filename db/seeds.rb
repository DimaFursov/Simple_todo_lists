1.times do |n|
  User.create!(name:  "Example User",
             email: "example@mail.com",
             password:              "123123",
             password_confirmation: "123123")
end
users = User.order(:created_at).take(3)
1.times do
  users.each { |user| user.projects.create!(name: "Garage") }
end
3.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.projects.create!(name: content) }
end
projects = Project.order(:created_at).take(3)
30.times do
  content = Faker::Lorem.sentence(5)
  projects.each { |project| project.tasks.create!(name: content, status: true) }
end
30.times do
  content = Faker::Lorem.sentence(5)
  projects.each { |project| project.tasks.create!(name: content, status: false)}
end