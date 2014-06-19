ECommerce::Application.routes.draw do

  resources :product_brands

  resources :product_categories

  resources :product_items

  resources :profile_details
  devise_for :users
	devise_scope :user do 
		get "sign_in", :to => "devise/sessions#new" 
		root :to => 'devise/sessions#new'
	end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
	resources :admins do
		collection do
			get 'retailer_requests'
			get 'assign'
			get 'assign_item'
			get 'product_approval'
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
	resources :home do
		#~ get :search, :on => :collection
	end
	# Example of regular route:
  get 'home/info_graphics' => 'home#info_graphics'
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
