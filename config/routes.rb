Rails.application.routes.draw do
  root to: 'categories#index'
  devise_for :users, controllers: { registrations: 'registrations/registrations' }
  resources :users do
    resources :auctions, only: :index
    resources :received_comments, only: :index, controller: :comments
  end

  resources :categories, only: [:new, :create, :edit, :update, :destroy, :index] do
    resources :auctions do
      resources :bids, only: [:new, :create]
    end
  end

  resources :auctions, only: [:new, :create, :edit, :update, :destroy] do
    resources :comments, only: [:new, :create]
  end
end
