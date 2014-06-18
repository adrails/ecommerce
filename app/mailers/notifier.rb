class Notifier < ActionMailer::Base
  default from: "adrails123@gmail.com"
	
	def send_product_create_notification(product)
		@product = product
    mail(to: 'adrails123@gmail.com', subject: 'New Product Request')
	end
	
	def retailer_request(user)
		@user = user
    mail(to: 'adrails123@gmail.com', subject: 'New Retailer Request')
	end
	
	def retailer_notification(user)
		@user = user
		mail(to: @user.email, subject: 'You have Requested for a Retailer in Smartek Ecommerce')
	end
	
	def convey_appoval_to_retailer(product)
		@product = product
		mail(to: @product.user.email, subject: 'Congratulations!! Your Product is approved')
	end
	
	def convey_reject_to_retailer(product)
		@product = product
		mail(to: @product.user.email, subject: 'Sorry Your Product is rejected')
	end
end
