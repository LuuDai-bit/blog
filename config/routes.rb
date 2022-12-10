Rails.application.routes.draw do
  root 'admin/dashboard#index'

  namespace :admin do
    resources :users, only: %i[show edit update new create]
  end
end
