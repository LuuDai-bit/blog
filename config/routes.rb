Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }

  namespace :admin do
    root 'dashboard#index'
    get '/', to: 'dashboard#index'

    resources :users, only: %i[show edit update new create]
    resources :posts
    resources :reminders, only: %i[index edit update new create destroy]
    resources :categories, only: :index
    resources :announcements, except: %i[show destroy]
  end

  get '/:locale' => 'user/posts#index'
  scope "(:locale)", locale: /en|vi/ do
    root 'user/posts#index'
    get '/about', to: 'user/home#about'
    get '/contact', to: 'user/home#contact'

    namespace :user do
      resources :posts, only: %i[index show]
    end
  end
end
