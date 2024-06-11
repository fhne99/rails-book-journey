import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["query", "results"]

  connect() {
    console.log(this.queryTarget, this.resultsTarget)
  }
}
