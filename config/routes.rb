Rails.application.routes.draw do

  namespace :admin do
    get 'homes/top'
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :customers, only: [:index, :edit, :update, :show]
    resources :orders, only: [:show, :update] do
      resource :order_detail, only: [:update]
    end
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
   resources :customers, only: [:update, :edit, :destroy ]
     get 'customers/infomation/edit' => 'customers#edit'
     get 'customers/my_page' => 'customers#show'
     resources :items, only: [:index, :show]
     resources :orders, only:[:new, :index, :show, :create]
     post 'orders/confirm' => 'orders#confirm'
     get 'orders/complete' => 'orders#complete'
    resources :cart_items, only: [:show, :create, :update, :destroy]
  end

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about', as: 'about'
end
