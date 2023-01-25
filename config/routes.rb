Rails.application.routes.draw do

  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

root to: 'public/homes#top'
get "home/about" => "public/homes#about", as: "about"

  scope module: :public do
    delete '/cart_items/all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :items, only: [:index, :show]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
    resources :orders, only: [:new, :create, :index, :show]
    get '/customers/my_page' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    patch '/customers/update' => 'customers#update'
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: :unsubscribe
    patch '/customers/withdraw' => 'customers#withdraw', as: :withdrawal
    resources :postals, only: [:index, :edit, :create, :update, :destroy]
  end

  get 'items/new'
  post 'items' => 'items#create'

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:create, :index, :edit, :update]
    resources :items, only: [:index, :create, :new, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end

end
