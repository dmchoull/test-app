Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root 'devise/sessions#new'
    get '/profiles', to: 'profiles#index', as: :user_root
  end

  resources :profiles
end
