class ProfileDetail < ActiveRecord::Base
	# Setup accessible (or protected) attributes for your model
  attr_accessible :contact_no, :gender, :dob, :doj, :user_id
	
	#Associations
	belongs_to :user
	has_many :addresses, dependent: :destroy
	accepts_nested_attributes_for :addresses
end
