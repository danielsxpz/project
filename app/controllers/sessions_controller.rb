# app/controllers/sessions_controller.rb

class SessionsController < ApplicationController
  skip_before_action :set_current_librarian, only: [:new, :create]
  skip_before_action :require_password_change, only: [:new, :create]
  def new
    # Esta ação apenas renderiza a view de login (new.html.erb)
  end

  def create
    # Busca o bibliotecário no banco de dados pelo e-mail fornecido
    librarian = Librarian.find_by(email: params[:email])

    # Verifica se o bibliotecário existe E se a senha fornecida está correta
    if librarian&.authenticate(params[:password])
      # Se a autenticação for bem-sucedida, armazena o ID do bibliotecário na sessão
      session[:librarian_id] = librarian.id
      # Redireciona para uma página principal do sistema (vamos criar uma rota para isso depois)
      redirect_to root_path, notice: 'Login realizado com sucesso!' # Mude 'root_path' se necessário
    else
      # Se a autenticação falhar, exibe uma mensagem de erro e renderiza a página de login novamente
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