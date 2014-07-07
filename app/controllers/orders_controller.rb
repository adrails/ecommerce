class OrdersController < ApplicationController
	skip_before_filter :verify_authenticity_token  
	def billing_info
		@cart_id = params[:cart_id]
		@address_id = params[:address_id_val]
	end
	
	def checkout
		@gateway = Order.payment_gateway
		@credit_card = Order.payment_details(params)
		if @credit_card.valid?
      response = @gateway.authorize(100, @credit_card, :ip => "127.0.0.1")
			@order = Order.create(params)
			@cart = Cart.find(params[:cart_id])
			
			@order.product_ids = @cart.product_item_ids
			@order.retailer_approve = false
			@order.admin_approve = false
			@order.save
			
			@cart.product_item_ids = nil
			@cart.quantity = nil
			@cart.total = nil
			@cart.save
			@order.product_ids.each do |p|
				@product = ProductItem.find_by_id(p)
				Notifier.product_owner_details(@product).deliver
			end
			Notifier.order_details_notification(current_user,@order).deliver
      if response.success?
        @res = response.params
				flash[:notice] = "payment sucessfull"
      else
        @res = response.message
				flash[:notice] = response.message
      end
    else
      @res = "Credit card is not a valid. Please verify account informations" #@credit_card.errors.inspect
			flash[:notice] = @res
    end
		redirect_to root_path
	end
	
	def place_order_details
		@address = Address.new
		@profile_detail = ProfileDetail.find_by_user_id(current_user.id)
		@cart_id = params[:cart_id]
	end
	
	def approve_order
		@order=Order.all
	end
	
end
