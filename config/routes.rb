Rails.application.routes.draw do
  get "password_changes/edit"
  get "password_changes/update"
  # Rota para a página inicial
  root 'sessions#new' # Define a página de login como inicial

  # Rotas para cadastro de bibliotecários
  get 'signup', to: 'librarians#new'
  resources :librarians, only: [:create]

  # Rotas para login e logout
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'edit_password', to: 'password_changes#edit'
  patch 'edit_password', to: 'password_changes#update'
end

