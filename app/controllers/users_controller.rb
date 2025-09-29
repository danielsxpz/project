class UsersController < ApplicationController
  before_action :require_login
  before_action :require_non_admin

  def index
    @users = User.all.order(:full_name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.loan_password = SecureRandom.hex(4)

    if @user.save
      UserMailer.welcome_email(@user).deliver_now

      redirect_to books_path, notice: "Usuário cadastrado com sucesso! A senha de empréstimo foi enviada para o e-mail."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :cpf, :phone, :email)
  end
end