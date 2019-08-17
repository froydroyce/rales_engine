Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'items#index'
        get '/revenue', to: 'date#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/:id/favorite_customer', to: 'customer#show'
        get '/random', to: 'random#show'
      end

      namespace :customers do
        get '/:id/favorite_merchant', to: 'merchant#show'
      end

      resources :merchants, only: [:index, :show]
    end
  end
end
