class LoansController < ApplicationController
  before_action :require_login
  before_action :require_non_admin
  before_action :set_book

  def new
    if @book.status != 'Disponível'
      redirect_to books_path, alert: "Este livro não está disponível para empréstimo."
    end
    # A view 'new.html.erb' será renderizada
  end

  def create
    user = User.find_by(cpf: params[:cpf])

    if user.nil?
      flash.now[:alert] = "Usuário não encontrado. Verifique o CPF ou cadastre um novo usuário."
      render :new, status: :unprocessable_entity
    elsif user.loan_password == params[:loan_password]
      # Transação para garantir a integridade dos dados
      ActiveRecord::Base.transaction do
        @book.update!(status: 'Emprestado')
        Loan.create!(
          book: @book,
          user: user,
          loan_date: Date.today,
          due_date: calculate_due_date(Date.today, 15)
        )
      end
      redirect_to books_path, notice: "Livro emprestado com sucesso para #{user.full_name}!"
    else
      flash.now[:alert] = "Senha de empréstimo incorreta."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  # Função para calcular 15 dias úteis
  def calculate_due_date(start_date, business_days)
    due_date = start_date
    business_days.times do
      due_date += 1.day
      # Pula fins de semana
      due_date += 2.days while due_date.saturday? || due_date.sunday?
    end
    due_date
  end
end