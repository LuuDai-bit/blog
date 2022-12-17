Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  root 'user/posts#index'
  get '/about', to: 'home#about'
  get '/contact', to: 'home#contact'

  namespace :admin do
    resources :users, only: %i[show edit update new create]
    resources :posts
  end

  namespace :user do
    resources :posts, only: %i[index show]
  end
end
