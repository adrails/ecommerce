# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



#Create here user role_type
["ADMIN", "RETAILER", "CUSTOMER"].each { |role_type| Role.create(:role_type => role_type) }

user_list = [
  [ "Online Shoppings", "adrails123@gmail.com", "EC_ADMIN", "EC_ADMIN", 1 ],
]


user_list.each do |user|
  user = User.new( :name=>user[0], :email=>user[1], :password=>user[2], :password_confirmation =>user[3], :role_id=>user[4])
	user.skip_confirmation!
	user.save
end