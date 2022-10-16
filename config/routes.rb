Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  resources :service_orders do
    get 'search', on: :collection
  end

  authenticate :user do
    resources :service_orders, only: [:index, :show, :new, :create, :edit, :update] do
      resources :calculations, only: [:index, :show, :new, :create] do
        post 'started', on: :member
      end
      post 'calculated', on: :member
      post 'closed', on: :member
    end
    resources :vehicles, only: [:index, :new, :create, :edit, :update] do
      get 'search', on: :collection
    end
    resources :costs, only: [:index]
    resources :transportation_modals, only: [:index, :show, :new, :create, :edit, :update] do
      post 'inactived', on: :member
      resources :costs, only: [:new, :create, :edit,:update]
      resources :timescales, only: [:new, :create, :edit, :update]
    end
  end

end
