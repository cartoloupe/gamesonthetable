# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: 'a', password: 'a')
User.create(name: 'b', password: 'b')

Move.create(users_id: 1, number_of_moves: 5)
Move.create(users_id: 2, number_of_moves: 1)
Move.create(users_id: 2, number_of_moves: 3)
Move.create(users_id: 1, number_of_moves: 5)
