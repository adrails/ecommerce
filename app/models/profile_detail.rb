class ProfileDetail < ActiveRecord::Base
	# Setup accessible (or protected) attributes for your model
  attr_accessible :contact_no, :gender, :dob, :doj, :user_id
	
	#Associations
	belongs_to :user
end
