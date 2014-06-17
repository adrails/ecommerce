class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
				 
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :role_type,:retailer_approval,:desc
	
	has_one :profile_detail
	has_many :product_items
	
	def self.admin?(user)
		if user.role_type == "ADMIN" && user.role_type != nil
			return true
		else
			return false
		end
	end
	
	
	def self.retailer?(user)
		if user.role_type == "RETAILER" && user.role_type != nil
			return true
		else
			return false
		end
	end

end
