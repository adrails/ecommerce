class ProfileDetail < ActiveRecord::Base
	# Setup accessible (or protected) attributes for your model
  attr_accessible :contact_no, :gender, :dob, :doj, :user_id
	
	#Associations
	belongs_to :user
	
 has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
