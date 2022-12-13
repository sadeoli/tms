# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  root to: 'home#index'

  resources :service_orders, except: %i[index show new create edit update destroy] do
    get 'search', on: :collection
  end

  authenticate :user do
    resources :service_orders, only: %i[index show new create edit update] do
      resources :calculations, except: %i[index show new create edit update destroy] do
        post 'started', on: :member
      end
      post 'calculated', on: :member
      post 'closed', on: :member
      post 'filter', on: :collection
    end
    resources :vehicles, only: %i[index new create edit update] do
      get 'search', on: :collection
    end
    resources :costs, only: [:index]
    resources :transportation_modals, only: %i[index show new create edit update] do
      post 'inactived', on: :member
      resources :costs, only: %i[new create edit update]
      resources :timescales, only: %i[new create edit update]
    end
  end
end
