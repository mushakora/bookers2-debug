Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  get 'search' => 'search#search'
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
