class BooksController < ApplicationController
  layout 'public', only: [:show]

  before_action :require_login, except: [:show]
  before_action :require_non_admin, except: [:show]

  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :load_categories, only: [:new, :create, :edit, :update]

  def index
    # Carrega as categorias para o dropdown de filtro
    @categories = Category.all.order(:name)
    
    # Começa a busca com todos os livros
    @books = Book.includes(:category)

    # Filtra pelo título do livro, se o parâmetro 'query' for fornecido
    if params[:query].present?
      @books = @books.where("title ILIKE ?", "%#{params[:query]}%")
    end

    # Filtra pela categoria, se o parâmetro 'category' for fornecido
    if params[:category].present?
      @books = @books.where(category_id: params[:category])
    end

    # Ordena os resultados finais por título
    @books = @books.order(:title)
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: 'Livro cadastrado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to books_path, notice: 'Livro atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'Livro deletado com sucesso.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def load_categories
    @categories = Category.all.order(:name)
  end

  def book_params
    params.require(:book).permit(:title, :author, :category_id, :observations)
  end
  
  def require_non_admin
    redirect_to admin_librarians_path, alert: "Administradores não gerenciam o acervo." if Current.librarian&.admin?
  end
end