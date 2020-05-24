Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  get 'search' => 'searches#search',as: :search
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users,　except: [:new, :destroy] do
    member do
  		get :follows
  		get :followers
    end
  end
  resources :books, except: [:new] do
  	resource :favorites, only: [:create, :destroy]
  	resource :book_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]

end
