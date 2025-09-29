class SessionsController < ApplicationController
  skip_before_action :set_current_librarian, only: [:new, :create]
  skip_before_action :require_password_change, only: [:new, :create]
  def new
    # Esta ação apenas renderiza a view de login (new.html.erb)
  end

  def create
    librarian = Librarian.find_by(email: params[:email])

    if librarian&.authenticate(params[:password])
      session[:librarian_id] = librarian.id
      
      # Define o usuário atual para que possamos verificar se é admin
      Current.librarian = librarian

      # Verificação do tipo de usuário para o redirecionamento
      if Current.librarian.admin?
        redirect_to admin_librarians_path, notice: 'Login de administrador realizado com sucesso!'
      else
        redirect_to root_path, notice: 'Login realizado com sucesso!'
      end
    else
      flash.now[:alert] = 'E-mail ou senha inválidos.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # Remove o ID do bibliotecário da sessão, efetivamente fazendo o logout
    session[:librarian_id] = nil
    redirect_to login_path, notice: 'Logout realizado com sucesso!'
  end
end