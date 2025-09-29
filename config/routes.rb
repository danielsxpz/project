Rails.application.routes.draw do
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
  get 'dashboard', to: 'books#index' # O dashboard agora é a lista de livros
  resources :books, except: [:show]
  resources :categories, except: [:show]
  resources :users, only: [:index, :new, :create]

  # --- Área do Administrador ---
  namespace :admin do
    resources :librarians, only: [:index, :new, :create, :destroy]
  end
end