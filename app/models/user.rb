class User < ActiveRecord::Base
	after_create :create_cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
				 
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :role_type,:retailer_approval,:desc
	
	has_one :profile_detail
	has_many :product_items
	has_one :cart, dependent: :destroy
	
	def self.find_role?(user)
		if user.role_type == "ADMIN"
			return "A"
		elsif user.role_type == "RETAILER"
			return "B"
		elsif user.role_type == "CUSTOMER"
			return "C"
		else
			return nil
		end
	end

	def self.create_cart
		self.cart.create
	end
	
end
