class OrdersController < ApplicationController
	skip_before_filter :verify_authenticity_token  
	def billing_info

	end
	def checkout
		@gateway = Order.payment_gateway
		@credit_card = Order.payment_details(params)
		if @credit_card.valid?
      response = @gateway.authorize(100, @credit_card, :ip => "127.0.0.1")
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
		p "ddddddddddddddddddddddddddddD"
		p @res
		redirect_to product_items_path
	end
end
