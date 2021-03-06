Rails.application.routes.draw do

  devise_for :users,
        controllers: {
          sessions: 'users/sessions',
          registrations: 'users/registrations',
          passwords: 'users/passwords',
          confirmations: 'users/confirmations'
        }

  get 'home', to: 'home#index'

  root to: 'home#index'

  resources :users do
    member do
      get 'restore'
    end

    collection do
      get 'deleted'
    end
  end

  resources :tickets do
    member do
      get 'restore'
      put 'update_status'
    end

    collection do
      get 'deleted'
    end
  end

  resources :departments do
    collection do
      get 'restore'
      get 'deleted'
    end
  end

  resources :issue_summaries do
    collection do
      get 'restore'
      get 'deleted'
    end
  end

  resources :users, only: [:index, :show, :destroy]
  resources :tickets, only: [:index, :new, :show, :destroy], :except => [ :create ] do
  post "create" => "tickets#create", :as => :create, :path => 'new', :on => :collection
end
  resources :posts, only: [:index, :new, :create]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'users/sessions#new'

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

  get "*path" => redirect("/404")

end
