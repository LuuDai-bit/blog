Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  root 'admin/dashboard#index'

  namespace :admin do
    resources :users, only: %i[show edit update new create]
    resources :posts
  end

  namespace :user do
    resources :posts, only: %i[index show]
  end
end
