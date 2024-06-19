import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["query"]

  connect() {
    console.log("book search controller connected")
  }

  search(event) {
    event.preventDefault()
    const query = this.queryTarget.value

    if (query.length === 0) {
      alert("Veuillez entrer un terme de recherche.")
      return
    }
    window.location.href = `/search_results.html?q=${encodeURIComponent(query)}`
  }
}
