Rails.application.routes.draw do
  get "dashboard/index"
  root 'dashboard#index'

  # Rotas para login e logout (permanecem as mesmas)
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Rota para alteração de senha (permanece a mesma)
  get 'edit_password', to: 'password_changes#edit'
  patch 'edit_password', to: 'password_changes#update'

  # NOVO NAMESPACE PARA ADMINISTRAÇÃO
  namespace :admin do
    # Rota para a página de cadastro de novos bibliotecários pelo admin
    # Ex: /admin/librarians/new
    resources :librarians, only: [:new, :create]
  end
end