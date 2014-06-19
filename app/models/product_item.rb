class ProductItem < ActiveRecord::Base
	attr_accessible :title,:available_quantity,:description,:price,:user_id,:product_category_id,:product_brand_id,:is_active
	belongs_to :user
	has_many :pictures, :dependent => :destroy
	
	def self.search_by_keyword(keyword)
		return where("title like ?","%#{keyword}%")
	end
end