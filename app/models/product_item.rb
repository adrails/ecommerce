class ProductItem < ActiveRecord::Base
	attr_accessible :title,:available_quantity,:description,:price,:user_id,:product_category_id,:product_brand_id,:is_active
	belongs_to :user
end