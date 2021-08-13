require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end
  get '/sitemap.xml.gz', to: redirect("https://s3-eu-west-1.amazonaws.com/#{ENV["AWS_FOG_DIRECTORY"]}/sitemap.xml.gz")

  devise_for :stores, controllers: {
    registrations: 'stores/registrations',
    sessions: 'stores/sessions',
    passwords: 'stores/passwords'
  }
  devise_for :clients, controllers: {
    registrations: 'clients/registrations',
    sessions: 'clients/sessions',
    passwords: 'clients/passwords'
  }
  devise_for :admins, controllers: {
    sessions: 'clients/sessions'
  }

  namespace :store do 
    resources :products
    resources :store_categories
    resources :discounts, except: [:edit, :update]
    resources :profiles, except: [:destroy]
    resources :shippings, except: [:destroy]
  end
  
  namespace :administrative do
    resources :clients, only: [:index]
    resources :stores, only: [:index]
    patch '/login_client/:id', to:"clients#login", as: :login_client
    patch '/login_store/:id', to:"stores#login", as: :login_store
  end

  namespace :client do 
    resources :orders, except: [:edit, :update, :destroy]
    resources :carts, only: [:show] do
      get :empty_cart, to: 'carts#empty_cart', on: :collection
    end
    resources :address_clients, only: [:edit, :update]

    resources :order_products, only: [:create, :update, :destroy] do
      get :add_one, to: 'order_products#add_one_order_product', on: :member
      get :remove_one, to: 'order_products#remove_one_order_product', on: :member
      resources :reviews, except: [:index, :show, :destroy]
    end
  end
  
  get '/lojas', to: redirect('/stores/sign_in')
  resources :suporte, only: [:index]
  resources :categories, only: [:show]
  resources :products, only: [:show]
  resources :home, only: [:index, :show], param: :slug, :path => '/'
  root 'home#index'

end
