module ApplicationHelper
	def find_product_item(product_item)
		return ProductItem.find(product_item)
	end
	
	def order_item(product_item)
		return Order.find(product_item)
	end
end
