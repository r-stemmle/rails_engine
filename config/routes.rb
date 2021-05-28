Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :revenue do
        get 'weekly', to: 'weekly#index'
        get 'merchants', to: 'merchants#index'
        get 'merchants(/:id)', to: 'merchants#show'
        get 'items', to: 'items#index'
      end
      get 'merchants/find'
      get 'items/find_all'
      resources :items do
        resource :merchant, controller: 'items/merchant', only: :show
      end
      resources :merchants, only: [:index, :show] do
        resources :items, controller: 'merchants/items', only: :index
      end
    end
  end
end
