class Admin::LibrariansController < ApplicationController
  # Garante que todas as ações neste controller exigem um admin logado
  before_action :require_admin

  def new
    @librarian = Librarian.new
  end

  def create
    @librarian = Librarian.new(librarian_params)
    # A senha provisória é definida automaticamente pelo `has_secure_password`
    # E o `must_change_password` já é `true` por padrão.

    if @librarian.save
      # AQUI: Futuramente, você pode implementar o envio de e-mail com a senha provisória.
      redirect_to new_admin_librarian_path, notice: "Bibliotecário cadastrado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def librarian_params
    # O admin define apenas nome, e-mail e uma senha provisória.
    params.require(:librarian).permit(:name, :email, :password, :password_confirmation)
  end
end