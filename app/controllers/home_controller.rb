class HomeController < ApplicationController
	#~ autocomplete :product_items, :title, :full => true
	
	def info_graphics
	end
	
	def search
		@product_items = ProductItem.search_by_keyword(params[:key]).paginate(:page => params[:page], :per_page => 4)
	end
	
end
