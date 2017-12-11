require_relative '../lib/subdomain'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy'
  end
  devise_scope :user do
    get 'sign_up', to: 'devise/registrations#new'
  end

  # Global admin
  namespace :admin do
    get '/', to: 'home#index'
    resources :organizations
    resources :users, except: :new do
      resources :user_organizations, path: :organizations
    end
  end

  # Org admin
  resources :organizations, only: %i[index show edit update] do
    resources :user_organizations, path: :users, only: %i[edit update destroy]
    resources :interest_types
  end

  # Every user
  resources :users, only: %i[show edit update]
  resources :organizations, only: [] do
    resources :users, only: [] do
      resources :interests
    end
  end

  constraints Subdomain do
    match '', to: 'organizations#show_on_subdomain', via: [:get]
  end

  root to: 'home#index'
end
