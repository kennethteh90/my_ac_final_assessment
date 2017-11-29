# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count < 3
  User.create(email: 'user1@example.com' , password: '123456')
  User.create(email: 'user2@example.com' , password: '123456')
  User.create(email: 'user3@example.com' , password: '123456')
  User.find(1).follow(User.find(2))
  User.find(2).follow(User.find(1))
  User.find(3).follow(User.find(1))
  User.find(3).follow(User.find(2))
end

5.times do
  User.find(1).notes.create(title: Faker::DrWho.catch_phrase, body: Faker::ChuckNorris.fact)
  User.find(2).notes.create(title: Faker::GameOfThrones.character, body: Faker::MostInterestingManInTheWorld.quote)
  User.find(3).notes.create(title: Faker::GameOfThrones.character, body: Faker::MostInterestingManInTheWorld.quote)
end

User.find(1).like(User.find(2).notes.last)
User.find(2).like(User.find(3).notes.first)
User.find(3).like(User.find(1).notes.first)
