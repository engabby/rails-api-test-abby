# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
  comment = Comment.create(content: Faker::Lorem.word, user_id: User.first.id,card_id:Card.first.id)
  #todo.items.create(name: Faker::Lorem.word, done: false)
end
