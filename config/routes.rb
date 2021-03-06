ECommerce::Application.routes.draw do

  resources :carts do
		collection do
			get 'my_cart'
			delete 'remove_from_my_cart'
			get 'get_quantity'
		end
	end
	

  resources :product_brands

  resources :product_categories

  resources :product_items

  resources :profile_details
  devise_for :users
	devise_scope :user do 
		get "sign_in", :to => "devise/sessions#new" 
		#~ root :to => 'devise/sessions#new'
	end
	root :to => 'home#index'
	get 'home/index' => 'home#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
	resources :admins do
		collection do
			get 'retailer_requests'
			get 'assign'
			get 'assign_item'
			get 'product_approval'
			get 'get_role_type'
		end
		member do
			post 'approve_and_reject_retailer'
			post 'approve_and_reject_product'
		end
	end
	resources :customers
	resources :addresses
	resources :users
	resources :retailers

	# Example of regular route:
  get 'home/info_graphics_ecommerce' => 'home#info_graphics_ecommerce'
  get 'home/info_graphics_youtube' => 'home#info_graphics_youtube'
  get 'orders/billing_info' => 'orders#billing_info'
  get 'orders/place_order_details' => 'orders#place_order_details'
  post 'orders/checkout' => 'orders#checkout'
  get 'orders/approve_order' => 'orders#approve_order'
  #post 'orders/approve_and_reject_retailer_product' => 'orders#approve_and_reject_retailer_product'
	
	resources :orders do
		member do
			post 'approve_and_reject_retailer_product'
		end
	end
  get 'home/search' => 'home#search'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
