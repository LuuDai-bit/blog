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
    resources :about_me, only: %i[update] do
      get '/detail', to: 'about_me#detail', on: :collection
    end
    resources :settings, only: :index do
      get '/edit', to: 'settings#edit', on: :collection
      patch '/update', to: 'settings#update', on: :collection
    end
    resources :passwords, only: %i[edit update]
    resources :job_logs, only: :index
    resources :auth_tokens, only: %i[index create show destroy]
  end

  namespace :gateway do
    resources :comments, only: :create
  end

  get '/:locale' => 'user/technical_posts#index'

  scope "(:locale)", locale: /en|vi/ do
    root 'user/technical_posts#index'
    get '/about', to: 'user/home#about'
    get '/contact', to: 'user/home#contact'
    get '/idle_talks' => 'user/idle_talks#index'

    namespace :user do
      resources :technical_posts, only: %i[index show]
      resources :idle_talks, only: %i[index show]
    end
  end
end
