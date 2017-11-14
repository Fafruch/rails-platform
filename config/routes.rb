require '/Users/Fafruch/RubymineProjects/selleo-test-project/selleo-app/lib/subdomain.rb'

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

  resources :users, only: %i[show edit update]

  constraints Subdomain do
    match '', to: 'organizations#show', via: [:get]
  end

  root to: 'home#index'
end
