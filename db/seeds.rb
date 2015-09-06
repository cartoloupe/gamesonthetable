# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u1 = User.create(name: 'todd', email: 'todd@demo.com', password: 'password')
u2 = User.create(name: 'vasanth', email: 'vasanth@demo.com', password: 'password')
u3 = User.create(name: 'tirthankar', email: 'tirthankar@demo.com', password: 'password')

g1 = Game.create(name: 'Game 1', num_users: 3, status: 'open')
g1 = Game.create(name: 'Game 2', num_users: 3, status: 'open')

p1 = Player.create(name: 'Player todd', comment: 'Comment', user_id: u1.id, game_id: g1.id)
p2 = Player.create(name: 'Player vasanth', comment: 'Comment', user_id: u2.id, game_id: g1.id)
p2 = Player.create(name: 'Player Tirthankar', comment: 'Comment', user_id: u2.id, game_id: g1.id)

Message.create(game_id: g1.id, user_id: u1.id, the_text: 'Message 1')
Message.create(game_id: g1.id, user_id: u2.id, the_text: 'Message 2')
Message.create(game_id: g2.id, user_id: u3.id, the_text: 'Message 3')

#
# Move.create(users_id: 1, number_of_moves: 5)
# Move.create(users_id: 2, number_of_moves: 1)
# Move.create(users_id: 2, number_of_moves: 3)
# Move.create(users_id: 1, number_of_moves: 5)
