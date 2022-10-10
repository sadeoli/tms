Rails.application.routes.draw do
  devise_for :users
  authenticate :user do
    root to: 'home#index'
    resources :service_orders, only: [:index, :show, :new, :create]
    resources :vehicles, only: [:index, :show, :new, :create]
    resources :costs, only: [:index, :show, :new, :create]
    resources :transportation_modals, only: [:index, :show, :new, :create, :edit, :update] do
      post 'inactived', on: :member
    end
  end

end
