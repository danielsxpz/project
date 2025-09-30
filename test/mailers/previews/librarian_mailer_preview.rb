# Preview all emails at http://localhost:3000/rails/mailers/librarian_mailer
class LibrarianMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/librarian_mailer/password_reset
  def password_reset
    LibrarianMailer.password_reset
  end
end
