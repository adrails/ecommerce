class Cart < ActiveRecord::Base
	# Setup accessible (or protected) attributes for your model
  attr_accessible :user_id, :product_item_ids
	
	belongs_to :user
	serialize :product_item_ids
	
end
