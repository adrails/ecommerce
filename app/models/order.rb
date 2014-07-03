class Order < ActiveRecord::Base
	belongs_to :cart
	attr_accessible :cart_id,:amount_paid,:address_id,:ip,:first_name, :last_name,:credit_card_no,:card_type,:expiry_month,:expiry_year,:cvv
	serialize :product_ids
	
	def self.payment_gateway
    #payment gateway configuration has avliablein payment_gateway.yml.
    ActiveMerchant::Billing::Base.mode = Payment_mode.to_sym
    ActiveMerchant::Billing::PaypalGateway.new( :login => Login_id, :signature => Transaction_key, :password => Password)
  end
	
	def self.payment_details(params)
		ActiveMerchant::Billing::CreditCard.new(
		:number     => params[:number],
		:month      => params[:month],
		:year       => params[:year],
		:first_name => params[:first_name],
		:last_name  => params[:last_name],
		:verification_value  => params[:cvv]
		)
  end

end



