class DashboardController < ApplicationController
  # Garante que o usuário deve estar logado para acessar qualquer página aqui
  before_action :require_login

  def index
    # Esta página irá simplesmente renderizar a view 'index.html.erb'
  end
end