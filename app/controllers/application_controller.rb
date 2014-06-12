class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	
	rescue_from ActiveRecord::RecordNotFound, :with => :not_found
	rescue_from ActionController::RoutingError, :with => :rescue_404

  def not_found
   redirect_to :controller=>'vendors', :action=>'index'
  end
  
  def rescue_404
     redirect_to :controller=>'vendors', :action=>'index'
	end
	 
	def after_sign_in_path_for(user)
		if user.role_type == "ADMIN"
		 admins_path
		else
		 customers_path
		end
	end
	
end
