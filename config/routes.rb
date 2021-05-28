Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'revenue/weekly'
      get 'revenue/items'
      get 'revenue/merchants'
      get 'revenue/merchants(/:id)', to: 'revenue#merchant'
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
