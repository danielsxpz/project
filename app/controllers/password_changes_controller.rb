class PasswordChangesController < ApplicationController
  # Pula o filtro de verificação nesta página específica para evitar um loop de redirect
  skip_before_action :require_password_change, only: [:edit, :update]

  def edit
    # A view 'edit' será renderizada
  end

  def update
    if Current.librarian.update(password_params)
      # Marca que o usuário não precisa mais trocar a senha
      Current.librarian.update_attribute(:must_change_password, false)
      redirect_to root_path, notice: "Senha atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:librarian).permit(:password, :password_confirmation)
  end
end