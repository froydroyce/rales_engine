Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'items#index'
        get '/revenue', to: 'date#index'
      end
      resources :merchants, only: [:index, :show]
    end
  end
end
