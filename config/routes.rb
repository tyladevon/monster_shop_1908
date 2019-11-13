Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"
    get '/', to: 'welcome#index'

  resources :merchants
    get '/merchants', to: 'merchants#index'
    get '/merchants/new', to: 'merchants#new'
    post '/merchants', to: 'merchants#create'
    get '/merchants/:id/edit', to: 'merchants#edit'
    patch '/merchants/:id', to: 'merchants#update'
    get '/merchants/:id', to: 'merchants#show'
    delete '/merchants/:id', to: 'merchants#destroy'

  resources :items, only:[:index, :show, :edit, :update, :destroy]
    get '/items', to: 'items#index'
    get '/items/:id', to: 'items#show'
    get '/items/:id', to: 'items#edit'
    patch '/items/:id', to: 'items#update'
    delete 'items/:id', to: 'items#destroy'

  resources :merchants, only:[] do
    resources :items, only:[:index, :new, :create]
  end
    get '/merchants/:merchant_id/items/', to: 'items#index'
    get '/merchants/:merchant_id/items/new', to: 'items#new'
    post '/merchants/:merchant_id/items', to: 'items#create'

  resources :items, only:[] do
    resources :reviews, only:[:new, :create]
  end
    get '/items/:item_id/reviews/new', to: 'reviews#new'
    post '/items/:item_id/reviews', to: 'reviews#create'

  resources :reviews, only:[:edit, :update, :destroy]
    get '/reviews/:id/edit', to: 'reviews#edit'
    patch '/reviews/:id', to: 'reviews#update'
    delete '/reviews/:id', to: 'reviews#destroy'

  resources :orders, only:[:new, :create, :show]
    get '/orders/:id', to: 'orders#show'
    get '/orders/new', to: 'orders#new'
    post '/orders', to: 'orders#create'

  resources :item_orders, only: [:update]
    patch '/item_orders/:id', to: 'item_orders#update'

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id/:increment_decrement", to: "cart#increment_decrement"

  get "/login", to: "sessions#new"
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get "/register", to: "users#new"
  post '/users', to: "users#create"
  get '/profile', to: "users#show"
  get '/profile/edit/:type', to: "users#edit"
  patch '/profile', to: 'users#update'

  get "/profile/orders", to: "orders#index"
  get "/profile/orders/:id", to: 'orders#show'
  patch "/profile/orders/:id", to: 'orders#update'

  namespace :admin do
    get '/', to: 'dashboard#index'
    get '/merchants', to: 'merchants#index'
    patch '/merchants/:id/:type', to: 'merchants#update'
    get '/users/:id', to: 'users#show'
    get '/users', to: 'users#index'
    get '/merchants/:id', to: 'merchants#show'
    patch '/orders/:id', to: 'orders#update'
  end

  namespace :merchant do
    get '/', to: 'dashboard#index'
    get '/orders/:id', to: 'orders#show'
    get '/items', to: "items#index"
    get '/items/new', to: 'items#new'
    patch '/items/:id/:type', to: "items#update"
    post '/items', to: 'items#create'
    delete '/items/:id', to: "items#destroy"
    get '/items/:id', to: "items#edit"
    patch '/items/:id/:type', to: "items#update"
  end
end
