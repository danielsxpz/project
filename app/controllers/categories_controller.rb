class CategoriesController < ApplicationController
  # Garante que o usuário está logado
  before_action :require_login
  # Garante que o usuário NÃO é um admin
  before_action :require_non_admin
  
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all.order(:name)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Categoria criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Categoria atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # Adicionar lógica para verificar se a categoria está em uso antes de deletar (futuro)
    @category.destroy
    redirect_to categories_path, notice: 'Categoria deletada com sucesso.'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
  
  # Novo filtro para garantir que apenas bibliotecários padrão acessem
  def require_non_admin
    redirect_to admin_librarians_path, alert: "Administradores não gerenciam categorias." if Current.librarian&.admin?
  end
end