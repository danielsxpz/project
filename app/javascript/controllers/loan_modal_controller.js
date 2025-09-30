import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal", "details", "bookTitle", "userName", "loanDate", "dueDate" ]

  // Abre o modal e busca os dados do empréstimo
  async open(event) {
    const loanId = event.currentTarget.dataset.loanId;
    const bookTitle = event.currentTarget.dataset.bookTitle;

    // Guarda o loanId e o título para usar na devolução
    this.element.dataset.loanId = loanId;
    
    // Mostra o modal
    this.modalTarget.classList.remove("hidden");

    // Preenche o título do livro imediatamente
    this.bookTitleTarget.textContent = bookTitle;

    // Busca os detalhes do empréstimo no servidor
    const response = await fetch(`/loans/${loanId}/details`);
    const data = await response.json();

    // Preenche os detalhes no modal
    this.userNameTarget.textContent = data.user_name;
    this.loanDateTarget.textContent = data.loan_date;
    this.dueDateTarget.textContent = data.due_date;
  }

  // Fecha o modal
  close() {
    this.modalTarget.classList.add("hidden");
  }

  // Lida com o clique no botão "Marcar como Devolvido"
  returnBook(event) {
    event.preventDefault();
    const loanId = this.element.dataset.loanId;
    const returnUrl = `/loans/${loanId}/return_book`;
    
    if (confirm("Tem certeza que deseja marcar este livro como devolvido?")) {
      // Pega o token CSRF da página para autenticar o pedido
      const csrfToken = document.querySelector("meta[name='csrf-token']").content;
      
      fetch(returnUrl, {
        method: 'PATCH',
        headers: {
          'X-CSRF-Token': csrfToken,
          'Content-Type': 'application/json'
        }
      }).then(response => {
        // Se a devolução for bem-sucedida, o backend redireciona, e o frontend segue o redirecionamento.
        if (response.redirected) {
          window.location.href = response.url;
        }
      });
    }
  }
}