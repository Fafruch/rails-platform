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

  get 'admin', to: 'admin#index'
  scope 'admin' do
    resources :users, except: :new
    resources :organizations, only: :index
  end

  resources :organizations, only: :show

  constraints Subdomain do
    match '', to: 'organizations#show_on_subdomain', via: [:get]
  end

  root to: 'home#index'
end
