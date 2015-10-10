Rails.application.routes.draw do



    get 'game/index'

  # manage routes
  resources :manage
  match 'manage/make_role/id' => 'manage#make_role', via: [:post]

  # home routes
    post 'home/index'
    get  'home/index', :as => 'home_get'

    get  'home/popup'

  # devise routes
    devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

    get '/users/:id/add_email' => 'users#add_email', via: [:get, :patch, :post], :as => :add_user_email

    get '/users/details/:id' => 'users#user_details', via: [:get], :as => :user_details
    get '/users/current_user_details' => 'users#current_user_details', via: [:get] , :as => :current_user_details



    get '/public/index' => 'public#index', via: [:get], :as => :common_chat
    # get '/error' =>
    #resources :users
    post 'users/save_email/' => 'users#save_email', via: [:post]

    root :to => 'home#index', via: [:get, :post], :as => :home


 # conf routes
    resources :confs, only: [:index, :new, :create, :edit, :update, :destroy]
    match 'confs/all_confs' => 'confs#all_confs', via: [:get]
    match 'confs/:id' => 'confs#add_conf', via: [:post]

 # game routes
    match 'game/start/:id' => 'game#index', via: [:get], :as => 'game_start'


 # presets routes
    resources :presets, only: [:index, :new, :create, :edit, :update, :destroy]

    match '/test' => 'presets#test', via: [:post, :get]
    match 'presets/all_presets' => 'presets#all_presets', via: [:get], :as => 'all_presets'
    match 'presets/:id' => 'presets#add_preset', via: [:post], :as => 'add_preset'

  # search routes
    match '/search' => 'search#index', :as => 'search', via: [:post, :get]
    match '/rebuild' => 'search#rebuild_indexes', :as => 'rebuid_indexes', via: [:post, :get]


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
end
