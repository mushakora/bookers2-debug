Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'

  resources :users,　except: [:new, :destroy]
  resources :books, except: [:new]

end
