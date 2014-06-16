class Address < ActiveRecord::Base
	attr_accessible :line_1, :line_2, :city, :state, :country, :pincode, :landmark, :profile_detail_id, :nick_name
end
