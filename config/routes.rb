Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  root 'user/posts#index'
  get '/about', to: 'user/home#about'
  get '/contact', to: 'user/home#contact'

  namespace :admin do
    root 'dashboard#index'
    get '/', to: 'dashboard#index'

    resources :users, only: %i[show edit update new create]
    resources :posts
    resources :reminds, only: %i[index edit update new create destroy]
  end

  namespace :user do
    resources :posts, only: %i[index show]
  end
end
