class PasswordChangesController < ApplicationController
  # Pula o filtro de verificação nesta página específica para evitar um loop de redirect
  skip_before_action :require_password_change, only: [:edit, :update]

  def edit
    # A view 'edit' será renderizada
  end
  

  def update
    if Current.librarian.update(password_params.merge(must_change_password: false))
      # Adicione uma verificação aqui também
      if Current.librarian.admin?
        redirect_to admin_librarians_path, notice: "Senha atualizada com sucesso!"
      else
        redirect_to books_path, notice: "Senha atualizada com sucesso!"
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:librarian).permit(:password, :password_confirmation)
  end
end