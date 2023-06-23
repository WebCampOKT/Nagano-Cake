Rails.application.routes.draw do

  namespace :admin do
    get 'homes/top'
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :customers, only: [:index, :edit, :update, :show, :update] do
      get 'orders' => 'orders#index'
    end
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
    get "search" => "searches#search"
  end
  namespace :public do
    get 'homes/top'
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  scope module: :public do
    get 'customers/my_page' => 'customers#show'
    get 'customers/infomation/edit' => 'customers#edit'
    patch  '/customers/infomation' => 'customers#update'
    # 顧客の退会確認画面
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    # 退会処理用のルーティング
    patch 'customers/withdrawal' => 'customers#withdrawal'
    resources :items, only: [:index, :show]
    get 'orders/complete' => 'orders#complete'
    resources :orders, only:[:new, :index, :show, :create]
    post 'orders/confirm' => 'orders#confirm'
    resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete "clear"
      end
    end
    get "search" => "searches#search"
    resources :genres, only: [:show]
  end

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about', as: 'about'
  get 'admin' => 'admin/homes#top', as: 'admin'
end
