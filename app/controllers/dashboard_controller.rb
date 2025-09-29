class DashboardController < ApplicationController
  # Garante que o usuário deve estar logado para acessar qualquer página aqui
  before_action :require_login

  def index
    # Esta página irá simplesmente renderizar a view 'index.html.erb'
  end

  private

  # Vamos adicionar este novo método de verificação no ApplicationController
  def require_login
    redirect_to login_path, alert: "Você precisa estar logado para acessar esta página." unless Current.librarian
  end
end