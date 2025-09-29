class UsersController < ApplicationController
  layout 'public'
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Gera uma senha aleatória de 8 caracteres
    @user.loan_password = SecureRandom.hex(4)

    if @user.save
      # Envia o e-mail de boas-vindas com a senha
      UserMailer.welcome_email(@user).deliver_now

      redirect_to root_path, notice: "Cadastro realizado com sucesso! Verifique seu e-mail para a senha de empréstimo."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :cpf, :phone, :email)
  end
end