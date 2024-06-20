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
        const firstTenBooks = data.docs.slice(0, 10)
        const extractedData = firstTenBooks.map(book => ({
          title: book.title,
          author: book.author_name ? book.author_name.join(', ') : "Auteur inconnu",
          publish_year: book.first_publish_year || "Inconnue",
          pages: book.number_of_pages_median || "Inconnue",
          cover: book.cover_i ? `https://covers.openlibrary.org/b/id/${book.cover_i}-M.jpg` : "https://via.placeholder.com/150?text=No+Cover",
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
      const cardHtml = `
      <div class="col-3">
        <div class="card-book-index">
          <img src="${book.cover}" alt="${book.title}">
          <div class="card-book-info">
            <h3 class="book-index-title my-1">${book.title}</h3>
            <h4 class="book-index-author">${book.author}</p>
            <p>Année de publication : ${book.publish_year}</p>
            <p>Pages : ${book.pages}</p>
            <a href="/books/add?title=${encodeURIComponent(book.title)}&author=${encodeURIComponent(book.author)}&publish_year=${encodeURIComponent(book.publish_year)}&cover=${encodeURIComponent(book.cover)}&pages=${encodeURIComponent(book.pages)}" class="btn btn-primary">Ajouter à ma bibliothèque</a>
          </div>
        </div>
        </div>
      `

      this.resultsTarget.insertAdjacentHTML("beforeend", cardHtml)
    })
  }
}
