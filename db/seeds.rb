# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_list = [
  [ "Online Shopping", "adrails123@gmail.com", "EC_ADMIN", "EC_ADMIN", "ADMIN" ],
]


user_list.each do |user|
  User.create( :name=>user[0], :email=>user[1], :password=>user[2], :password_confirmation =>user[3], :role_type=>user[4] )
end