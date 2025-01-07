// controllers/search_results_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["results"]

  connect() {
    console.log("Search results controller connected")
    this.searchBooks()
  }

  searchBooks() {
    const params = new URLSearchParams(window.location.search)
    const query = params.get("q")

    fetch(`https://openlibrary.org/search.json?q=${query}`)
      .then(response => response.json())
      .then(data => {
        const firstTenBooks = data.docs.slice(0, 12)
        const extractedData = firstTenBooks.map(book => ({
          title: book.title,
          author: book.author_name ? book.author_name.join(', ') : "Auteur inconnu",
          publish_year: book.first_publish_year || "Inconnue",
          number_of_pages: book.number_of_pages_median || "Inconnue",
          cover_url: book.cover_i ? `https://covers.openlibrary.org/b/id/${book.cover_i}-M.jpg` : "https://via.placeholder.com/150?text=No+Cover",
        }))

        this.displayResults(extractedData)
      })
  }

  displayResults(books) {
    if (books.length === 0) {
      this.resultsTarget.innerHTML = "<p>Aucun résultat trouvé.</p>"
      return
    }

    books.forEach(book => {
      const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

      const cardHtml = `
      <div class="col-3">
        <div class="card-book-index">
          <img src="${book.cover_url}" alt="${book.title}">
          <div class="card-book-info">
            <h3 class="book-index-title my-1">${book.title}</h3>
            <h4 class="book-index-author">${book.author}</p>
            <p>Année de publication : ${book.publish_year}</p>
            <p>Pages : ${book.number_of_pages}</p>
            <form action="/books" method="post">
        <!-- Inclus le CSRF Token pour la sécurité -->
        <input type="hidden" name="authenticity_token" value="${csrfToken}">

        <!-- Champs cachés avec les attributs du livre -->
        <input type="hidden" name="book[title]" value="${book.title}">
        <input type="hidden" name="book[author]" value="${book.author}">
        <input type="hidden" name="book[number_of_pages]" value="${book.number_of_pages}">
        <input type="hidden" name="book[cover_url]" value="${book.cover_url}">
        <input type="hidden" name="book[publish_year]" value="${book.publish_year}">

        <button type="submit" class="btn btn-primary">Ajouter ce livre</button>
      </form>
          </div>
        </div>
      </div>
      `
      this.resultsTarget.insertAdjacentHTML("beforeend", cardHtml)
    })
  }
}
