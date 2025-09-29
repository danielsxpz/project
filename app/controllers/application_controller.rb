class ApplicationController < ActionController::Base
  before_action :set_current_librarian
  before_action :require_password_change

  private

  def set_current_librarian
    # Encontra o bibliotecário pelo ID na sessão, se existir
    if session[:librarian_id]
      Current.librarian = Librarian.find_by(id: session[:librarian_id])
    end
  end

  def require_password_change
    # Se o bibliotecário estiver logado E precisar trocar a senha...
    if Current.librarian&.must_change_password?
      # ...redireciona para a página de alteração de senha, a menos que ele já esteja lá.
      redirect_to edit_password_path, alert: "Por favor, atualize sua senha para continuar." unless request.path == edit_password_path
    end
  end

  def require_admin
    # Redireciona para a página principal se o usuário não for admin
    redirect_to root_path, alert: "Acesso não autorizado." unless Current.librarian&.admin?
  end

  def require_login
    # Se não houver um usuário logado (Current.librarian), redireciona para a página de login
    redirect_to login_path, alert: "Você precisa estar logado para acessar esta página." unless Current.librarian
  end

end