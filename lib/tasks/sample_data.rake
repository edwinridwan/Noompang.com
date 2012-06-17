namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # users
    User.create!(first_name: "David",
                 last_name: "Haber",
                 email: "d@h.com",
                 password: "david90",
                 password_confirmation: "david90",
                 admin: true)
    User.create!(first_name: "Test",
                 last_name: "User",
                 email: "t@u.com",
                 password: "test90",
                 password_confirmation: "test90",
                 admin: true)
    8.times do |n|
      first_name  = Faker::Name.first_name
      last_name   = Faker::Name.last_name
      email = "example-#{n+1}@test.com"
      password  = "password"
      User.create!(first_name: first_name,
                   last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end         
  end
end
