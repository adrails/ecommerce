class OrdersController < ApplicationController
	skip_before_filter :verify_authenticity_token  
	def billing_info
		@cart_id = params[:cart_id]
		@address_id = params[:address_id_val]
	end
	
	def checkout
		p params
		p "##########################"
		@gateway = Order.payment_gateway
		@credit_card = Order.payment_details(params)
		if @credit_card.valid?
      response = @gateway.authorize(100, @credit_card, :ip => "127.0.0.1")
			Order.create(params)
			@cart = Cart.find(params[:cart_id])
			@cart.product_item_ids = nil
			@cart.save
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
		@profile_detail = ProfileDetail.find_by_user_id(current_user.id)
		@cart_id = params[:cart_id]
	end
	
end
