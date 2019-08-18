Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'items_sold#index'
        get '/revenue', to: 'date#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/:id/favorite_customer', to: 'customer#show'
        get '/random', to: 'random#show'

        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
      end

      namespace :customers do
        get '/:id/favorite_merchant', to: 'merchant#show'
      end

      namespace :items do
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'sold#index'
        get '/:id/best_day', to: 'date#show'
      end

      namespace :invoices do
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items', to: 'items#index'
        get '/:id/customer', to: 'customers#index'
        get '/:id/merchant', to: 'merchants#index'
      end

      resources :merchants, only: [:index, :show]
    end
  end
end
