Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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
  
  get 'welcome/welcome_index', :controller => 'welcome', :action => 'welcome_index', :as => 'welcome_index'
  root :to => 'welcome#welcome_index'
  post 'welcome/welcome_index'
  
  get 'welcome/sign_up', :controller => 'welcome', :action => 'sign_up', :as => 'sign_up'
  post 'welcome/sign_up'
  
  get '/cd_management/home_index', :controller => 'cd_management', :action => 'home_index', :as => 'home_index'
  #post '/cd_management/home_index/:id', :controller => 'cd_management', :action => 'home_index', :as => 'home_index'
  
  get '/cd_management/add_edit_artist', :controller => 'cd_management', :action => 'add_edit_artist', :as => 'add_edit_artist'
  post "/cd_management/add_edit_artist"
  
  get '/cd_management/artist_info', :controller => 'cd_management', :action => 'artist_info', :as => 'artist_info'
  post "/cd_management/artist_info"
  
  get "/cd_management/add_edit_album_path", :controller => 'cd_management', :action => 'add_edit_album_path', :as => 'add_edit_album_path'
  post "/cd_management/add_edit_album_path"
  
  get '/cd_management/add_edit_album', :controller => 'cd_management', :action => 'add_edit_album', :as => 'add_edit_album'
  post '/cd_management/add_edit_album'
  
  get '/cd_management/delete_artist', :controller => 'cd_management', :action => 'delete_artist', :as => 'delete_artist'
  post '/cd_management/delete_artist'
  
  get '/cd_management/search', :controller => 'cd_management', :action => 'search', :as => 'search'
  #post '/cd_management/home_index/:id'
  
end
