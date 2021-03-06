class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_filter :update_sanitized_params, if: :devise_controller?
	
	rescue_from ActiveRecord::RecordNotFound, :with => :not_found
	rescue_from ActionController::RoutingError, :with => :rescue_404

  def not_found
   redirect_to root_path
  end
  
  def rescue_404
     redirect_to root_path
	end
	 
	def after_sign_in_path_for(user)
		if user.role_id == 1
		 product_items_path
		elsif user.role_id == 2
		 product_items_path
		else 
		 root_path
		end
	end

	def update_sanitized_params
		devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :role_id,:email,:password)}
	end
	
	# Here checked user session
  def check_login
		if !current_user
			flash[:notice] = "Need to Login"
			redirect_to root_path 
		end
  end
	
end
