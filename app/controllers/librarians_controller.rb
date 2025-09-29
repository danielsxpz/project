class LibrariansController < ApplicationController
  def new
    # Inicializa um novo objeto Librarian para o formulário de cadastro
    @librarian = Librarian.new
  end

  def create
    # Cria um novo bibliotecário com os dados enviados pelo formulário
    @librarian = Librarian.new(librarian_params)

    if @librarian.save
      # Se o cadastro for bem-sucedido, redireciona para a página de login com uma mensagem de sucesso
      redirect_to login_path, notice: 'Cadastro realizado com sucesso! Por favor, faça o login.'
    else
      # Se houver erros de validação (ex: e-mail já existe), renderiza a página de cadastro novamente
      # para exibir os erros.
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Define quais parâmetros são permitidos para evitar vulnerabilidades de segurança
  def librarian_params
    params.require(:librarian).permit(:name, :email, :password, :password_confirmation)
  end
end