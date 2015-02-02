Rails.application.routes.draw do
  root to: 'categories#index'
  devise_for :users
  resources :users do
    resources :contracts, only: :index
    resources :auctions, only: :index
  end

  resources :categories, only: [:new, :create, :edit, :update, :destroy, :index] do
    resources :auctions do
      resources :bids, only: [:new, :create]
    end
  end
end
