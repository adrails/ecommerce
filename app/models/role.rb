class Role < ActiveRecord::Base
	  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_type, :user_id
	
	has_many :users
end
