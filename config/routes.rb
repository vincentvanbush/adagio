Rails.application.routes.draw do
  get 'search/show'

  root to: 'categories#index'
  devise_for :users, controllers: { registrations: 'registrations/registrations' }
  resources :users do
    resources :auctions, only: :index
    resources :received_comments, only: :index, controller: :comments
  end

  get '/search', to: 'search#show'

  resources :categories, only: [:new, :create, :edit, :update, :destroy, :index] do
    resources :auctions do
      resources :bids, only: [:new, :create]
    end
  end

  resources :auctions, only: [:new, :create, :index, :edit, :update, :destroy] do
    resources :comments, only: [:new, :create]
  end
end
