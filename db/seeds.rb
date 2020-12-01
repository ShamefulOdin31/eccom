# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

require "faker"

Category.destroy_all
Category.reset_pk_sequence
Game.destroy_all
Game.reset_pk_sequence

(0..4).each do |i|
  new_cat = Category.find_or_create_by(name: Faker::Game.genre)
  new_cat.save
end

(0..100).each do |i|
  cat_count = Category.count
  randomNum = rand(cat_count)
  rand_cat = Category.offset(randomNum).first
  name = Faker::Game.title

  search = name.gsub! " ", "_"

  new_game = rand_cat.games.create(
    name:  name,
    image: Faker::LoremFlickr.image(size: "100x120", search_terms: [search]),
    price: Faker::Number.between(from: 20, to: 80)
  )
  new_game.save
end
