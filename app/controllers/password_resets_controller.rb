class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @librarian = Librarian.find_by(email: params[:email])

    if @librarian
      # GERA UM TOKEN ASSINADO E COM VALIDADE DE 15 MINUTOS
      token = @librarian.generate_token_for(:password_reset)
      
      # Envia o e-mail com o novo token
      LibrarianMailer.password_reset(@librarian, token).deliver_now
    end
    
    # Mostra a mesma mensagem quer o e-mail exista ou não, por segurança.
    redirect_to root_path, notice: "Se o seu e-mail estiver no nosso sistema, você receberá um link para redefinir sua senha."
  end

  def edit
    # BUSCA O USUÁRIO PELO TOKEN ASSINADO
    @librarian = Librarian.find_by_token_for(:password_reset, params[:token])

    if @librarian.nil?
      redirect_to new_password_reset_path, alert: "O link de redefinição de senha é inválido ou expirou."
    end
  end

  def update
    @librarian = Librarian.find_by_token_for(:password_reset, params[:token])

    if @librarian
      if @librarian.update(librarian_params)
        redirect_to root_path, notice: "Sua senha foi redefinida com sucesso. Por favor, faça o login."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to new_password_reset_path, alert: "O link de redefinição de senha é inválido ou expirou."
    end
  end

  private

  def librarian_params
    params.require(:librarian).permit(:password, :password_confirmation)
  end
end