Rails.application.routes.draw do
  get "home/index"
  get "books/index"
  get "books/new"
  get "books/create"
  get "books/edit"
  get "books/update"
  get "books/destroy"
  get "categories/index"
  get "categories/new"
  get "categories/create"
  get "categories/edit"
  get "categories/update"
  get "categories/destroy"
  root 'home#index'

  get 'dashboard', to: 'dashboard#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'edit_password', to: 'password_changes#edit'
  patch 'edit_password', to: 'password_changes#update'

  namespace :admin do
    # Rota para a página de cadastro de novos bibliotecários pelo admin
    resources :librarians, only: [:index, :new, :create, :destroy]
  end

  resources :categories, except: [:show]
  resources :books

  get 'signup', to: 'users#new'
  resources :users, only: [:create]
end