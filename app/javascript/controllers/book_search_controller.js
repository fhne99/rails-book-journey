import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["query", "results"]

  connect() {
    console.log("book search controller connected")
  }

  search(event) {
    event.preventDefault()
    const query = this.queryTarget.value
    this.resultsTarget.innerHTML = ""

    if (query.length === 0) {
      alert("Veuillez entrer un terme de recherche.")
      return
    }

    fetch(`https://openlibrary.org/search.json?q=${query}`)
      .then(response => response.json())
      .then((data) => {
        data.docs.slice(0, 10).forEach((result) => {
        const bookTag = `<li class="list-group-item border-0">
                <p>Titre: ${result.title}</p>
                <p>Auteur: ${result.author_name ? result.author_name.join(", ") : "Auteur inconnu"}</p>
                <p>Année de publication: ${result.first_publish_year || "Inconnue"}</p>
                <p>Pages: ${result.number_of_pages_median || "Inconnue"}</p>
              </li>`
        this.resultsTarget.insertAdjacentHTML("beforeend", bookTag)
        })
      })
  }
}
