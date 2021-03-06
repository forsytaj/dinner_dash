DinnerDash::Application.routes.draw do
  resources :sales
  resources :reviews
  resources :sessions
  resources :orders, except: [:new] 
  resources :users
  resources :categories
  resources :items do 
    resources :reviews
  end 
  resources :menu, only: [:index]
  
  get 'cart', to: 'cart#show', as: :cart
  get 'cart/:item_id/add', to: 'cart#add', as: :add_item_cart
  get 'cart/:item_id/remove', to: 'cart#remove', as: :remove_item_cart
 
  get 'orders/:id/remove/:item_id', to: 'orders#remove_item', as: :remove_item_order
  get 'orders/:id/cancel', to: 'orders#cancel', as: :cancel_order
  get 'orders/:id/paid', to: 'orders#paid', as: :paid_order
  get 'orders/:id/completed', to: 'orders#completed', as: :completed_order
  
  get 'about', to: 'marketing#about'
  get 'faq', to: 'marketing#faq'
  
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'signout', to: 'sessions#destroy'

  
  root 'marketing#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
