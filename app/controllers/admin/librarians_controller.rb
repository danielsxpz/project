class Admin::LibrariansController < ApplicationController
  before_action :require_admin

  def index
    # ALTERAÇÃO: Filtra para mostrar apenas os bibliotecários que NÃO são administradores.
    @librarians = Librarian.where(admin: false).order(:id)
  end

  def new
    @librarian = Librarian.new
  end

  def create
    @librarian = Librarian.new(librarian_params)
    @librarian.must_change_password = true

    if @librarian.save
      redirect_to admin_librarians_path, notice: "Bibliotecário cadastrado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # NOVA AÇÃO PARA DELETAR UM BIBLIOTECÁRIO
  def destroy
    librarian = Librarian.find(params[:id])
    # Como uma segurança extra, garantimos que um admin não possa ser deletado por esta rota.
    unless librarian.admin?
      librarian.destroy
      redirect_to admin_librarians_path, notice: "Bibliotecário deletado com sucesso!"
    else
      redirect_to admin_librarians_path, alert: "Não é permitido deletar um administrador."
    end
  end

  private

  def librarian_params
    params.require(:librarian).permit(:name, :email, :password, :password_confirmation)
  end
end