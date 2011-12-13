IshankAssetMgmt::Application.routes.draw do

	as :admin do
		match '/admins/confirmation' => 'confirmations#update', :via => :put, :as => :update_admin_confirmation
	end
	
	devise_for :admins, :controllers => { :registrations => "admin/registrations", :confirmations => "confirmations"}
																
																													
	get "change_aem_form", :to => "asset_employee_mappings#change_aem_form", :as => "change_aem_form"
	
	
	get 'search', :to => "home#search", :as => :search
	
	resources "admins"
	
  resources "tags"
  
  resources "employees" do
  	get "disabled", :action => "disabled", :on => :collection
  end
  
  resources "asset_employee_mappings"
  
	resources 'assets'
	
	get "return/:type/:id", :to => "asset_employee_mappings#return_asset", :as => :return_asset
	
  get 'change_form_content', :to => "assets#change_form_content", :as => :change_form_content
	
	get 'populate_asset', :to => "asset_employee_mappings#populate_asset", :as => :populate_asset
	
	get 'show_tag', :to => "home#show_tag", :as => :show_tag
	
	root :to => "home#index"
	
	get ':resource/:id/history', :to => "asset_employee_mappings#history", :as => "show_history"
	
	put 'employee/:id/disable', :to => "employees#disable", :as => "disable_employee"
		
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
