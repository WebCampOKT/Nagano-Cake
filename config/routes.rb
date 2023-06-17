Rails.application.routes.draw do

  namespace :admin do
    get 'homes/top'
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :orders, only: [:show, :update] do
      resource :order_detail, only: [:update]
    end
  end
  namespace :public do
    get 'homes/top'
  end

  # 顧客用
  # URL /customers/sign_in ...
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
     resources :orders, only:[:new, :index, :show, :create, :confirm, :complete]
   end

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
