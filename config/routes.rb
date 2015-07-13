Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root 'devise/sessions#new'
    get '/welcome', to: 'welcome#index', as: :user_root
  end
end
