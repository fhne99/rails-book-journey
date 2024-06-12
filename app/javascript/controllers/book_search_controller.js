import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["query", "results"]

  connect() {
    console.log("book search controller connected")
  }

  search(event) {
    event.preventDefault()
    const query = this.queryTarget.value

    fetch(`https://openlibrary.org/search.json?q=${query}`)
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  }
}
