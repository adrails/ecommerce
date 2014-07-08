class User < ActiveRecord::Base
	after_create :create_cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
				 
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :role_id,:retailer_approval,:desc
	
	has_one :profile_detail
	belongs_to :role
	has_many :product_items
	has_one :cart, dependent: :destroy
	
	def self.find_role?(user)
		#Admin
		if user.role_id == 1
			return "A"
			#Retailer
		elsif user.role_id == 2
			return "B"
			#Customer
		elsif user.role_id == 3
			return "C"
		else
			return nil
		end
	end

	def self.create_cart
		self.cart.create
	end
	
end
