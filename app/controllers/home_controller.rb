class HomeController < ApplicationController
  layout 'public'
  def index
    # Carrega todas as categorias para o dropdown do filtro
    @categories = Category.all.order(:name)
    
    # Começa a busca por todos os livros
    @books = Book.includes(:category)

    # Filtra por TÍTULO se o parâmetro 'query' estiver presente
    if params[:query].present?
      @books = @books.where("title ILIKE ?", "%#{params[:query]}%")
    end

    # Filtra por CATEGORIA se o parâmetro 'category' estiver presente
    if params[:category].present?
      @books = @books.where(category_id: params[:category])
    end

    # Ordena os resultados pelo título
    @books = @books.order(:title)
  end
end