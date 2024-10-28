import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["status", "startDate", "endDate"]

  connect() {
    this.updateForm()
  }

  updateForm() {
    const status = this.statusTarget.value

    this.startDateTarget.classList.add("hidden")
    this.endDateTarget.classList.add("hidden")

    if (status === "lecture_en_cours") {
      this.startDateTarget.classList.remove("hidden")
    } else if (status === "lecture_terminée") {
      this.startDateTarget.classList.remove("hidden")
      this.endDateTarget.classList.remove("hidden")
    }
  }
}
