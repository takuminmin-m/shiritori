# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
server_user = User.create!(
  name: "Server",
  email: "example@example.com",
  password: "E.|&GxQ(SyYA83Svdu&EH/zSsxZY|."
)

room_ownership = server_user.room_ownerships.build
room = room_ownership.build_room(name: "みんなの部屋")
room_membership = room.room_memberships.build
room_membership.user = server_user
room_ownership.save
room.save
room_membership.save
