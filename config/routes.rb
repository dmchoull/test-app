Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root 'devise/sessions#new'
    get '/profile', to: 'profiles#profile', as: :user_root
  end

  resources :profiles
end
