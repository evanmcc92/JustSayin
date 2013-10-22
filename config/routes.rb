SocialLiving::Application.routes.draw do
  get "posts/index"
  get "posts/show"
  get "posts/edit"
  get "posts/create"
  get "posts/update"
  get "posts/destroy"
  get "posts/new"
    root :to => 'browse#home'
    get "browse/home"
    get "browse/votedup"
    get "browse/voteddown"
    get "browse/refreshposts"
    get "browse/update_poststream"
    get "browse/aboutus"
    get "browse/message"
    get "browse/profile"
    get "posts/index"
    get "posts/show"
    get "posts/edit"
    get "posts/update"
    get "posts/destroy"
    get "browse/profile"
    get "browse/message"
    get "browse/aboutus"
    get "refresh"  => "browse#refreshposts", :as => "refresh"
    get "votedup"  => "browse#votedup", :as => "votedup"
    get "voteddown"  => "browse#voteddown", :as => "voteddown"
    get "new_post" => "posts#new", :as => "new_post"
    
    #Sessions Users
    get "logout_user" => "sessions#destroy", :as => "logout_user"
    post "login_user" => "sessions#new", :as => "login_user"
    
    #Users
    get "signup" => "users#new", :as => "signup"
    
    resources :users
    resources :sessions
    resources :post
    resources :post_streams
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
