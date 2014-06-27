class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_filter :update_sanitized_params, if: :devise_controller?
	before_filter :create_cart
	
	rescue_from ActiveRecord::RecordNotFound, :with => :not_found
	rescue_from ActionController::RoutingError, :with => :rescue_404

  def not_found
   redirect_to root_path
  end
  
  def rescue_404
     redirect_to root_path
	end
	 
	def after_sign_in_path_for(user)
		if user.role_type == "ADMIN"
		 admins_path
		elsif user.role_type == "RETAILER"
		 product_items_path
		else 
		 root_path
		end
	end

	def update_sanitized_params
		devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :role_type,:email,:password)}
	end
	
	def self.create_cart
		self.cart.create
	end
	
end
