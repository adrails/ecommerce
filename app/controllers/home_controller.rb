class HomeController < ApplicationController
	#~ autocomplete :product_items, :title, :full => true
	
	def info_graphics_ecommerce
	end
	
	def info_graphics_youtube
	end	
	
	def search
		if current_user && User.find_role?(current_user) == "B"
			if params[:cont] == "product_items"
				@product_items = ProductItem.search_by_product(params[:key],current_user.id).paginate(:page => params[:page], :per_page => 4)
			else
				@product_items = ProductItem.search_by_keyword(params[:key]).paginate(:page => params[:page], :per_page => 4)
			end
		else
			@product_items = ProductItem.search_by_keyword(params[:key]).paginate(:page => params[:page], :per_page => 4)
		end
	end
	
	def index
		@product_items = ProductItem.all
	end
	
end
