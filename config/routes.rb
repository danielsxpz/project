Rails.application.routes.draw do
  get "loans/new"
  get "loans/create"
  # A página de login é a nova raiz da aplicação
  root 'sessions#new'

  # Rotas de login/logout para bibliotecários
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Rota para alteração de senha de primeiro acesso do bibliotecário
  get 'edit_password', to: 'password_changes#edit'
  patch 'edit_password', to: 'password_changes#update'

  # --- Área do Bibliotecário Padrão ---
  get 'dashboard', to: 'books#index'

  resources :books do
    resources :loans, only: [:new, :create]
  end

  resources :loans, only: [] do
    member do
      get :details # Rota para obter os detalhes do empréstimo (para o pop-up)
      patch :return_book # Rota para marcar o livro como devolvido
    end
  end

  resources :categories, except: [:show]
  resources :users, only: [:index, :new, :create]

  # --- Área do Administrador ---
  namespace :admin do
    resources :librarians, only: [:index, :new, :create, :destroy]
  end
end