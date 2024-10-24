import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['startDate', 'endDate', 'status']

  connect() {
    this.toggleDateFields()
    console.log("reading form controller connected")
  }

  toggleDateFields() {
    const statusValue = this.statusTarget.value

    if (statusValue === 'not_started') {
      this.startDateTarget.classList.add('hidden')
      this.endDateTarget.classList.add('hidden')
    } else if (statusValue === 'in_progress') {
      this.startDateTarget.classList.remove('hidden')
      this.endDateTarget.classList.add('hidden')
    } else if (statusValue === 'completed') {
      this.startDateTarget.classList.remove('hidden')
      this.endDateTarget.classList.remove('hidden')
    }
  }

  statusChanged() {
    this.toggleDateFields()
  }
}
