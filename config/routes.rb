SampleApp::Application.routes.draw do
  resources :users
  resources :rides
  resources :ride_requests
  resources :notifications, only: [:index]
  resources :sessions, only: [:new, :create, :destroy]

  # DEVISE AUTHENTICATION
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # USER
  match '/signup',              to: 'users#new'
  match '/signin',              to: 'sessions#new'
  match '/signout',             to: 'sessions#destroy', via: :delete

  # RIDE
  match '/newride',             to: 'rides#new'
  match '/searchride',          to: 'rides#search'
  match '/show_search_results', to: 'rides#show_search_results'
  match '/show_ride_requests',  to: 'rides#show_requests'
  match '/edit_ride',           to: 'rides#edit'
  match '/show_ride',           to: 'rides#show'

  # RIDEREQUESTS
  #match '/newrequest',         to: 'ride_requests#create'
  match '/accept_request',      to: 'ride_requests#accept'
  match '/decline_request',     to: 'ride_requests#decline'
  match '/redeem',              to: 'ride_requests#redeem'
  match '/rate_user',           to: 'ride_requests#rate_user'
  
  # STATIC PAGES
  match '/home',                to: 'static_pages#home'
  match '/contact',             to: 'static_pages#contact'
  match '/help',                to: 'static_pages#help'
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
  root :to => 'static_pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
