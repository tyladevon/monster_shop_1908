Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"
  resources :merchants
  resources :items, only:[:index, :show, :edit, :update, :destroy]

  resources :merchants, only:[] do
    resources :items, only:[:index, :new, :create]
  end

  resources :items, only:[] do
    resources :reviews, only:[:new, :create]
  end

  resources :reviews, only:[:edit, :update, :destroy]

  resources :orders, only:[:new, :create, :show]

  resources :item_orders, only: [:update]

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
