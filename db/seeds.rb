# Cria o Bibliotecário Administrador
Librarian.find_or_create_by!(email: "admin@gmail.com") do |librarian|
  librarian.name = "Admin"
  librarian.password = "password"
  librarian.password_confirmation = "password"
  librarian.admin = true
  librarian.must_change_password = false # Importante para não ficar preso na tela de troca de senha
end

puts "Bibliotecário Administrador criado com sucesso!"