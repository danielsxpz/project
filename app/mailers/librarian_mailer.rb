class LibrarianMailer < ApplicationMailer
  def password_reset(librarian, token) # Adicione 'token' como argumento
    @librarian = librarian
    @token = token # Crie uma variável de instância para a view
    mail to: librarian.email, subject: "Redefinição de Senha"
  end
end