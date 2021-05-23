Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items
      resources :customers
      resources :merchants do
        resources :items, controller: 'merchants/items', only: :index
      end
    end
  end
end
