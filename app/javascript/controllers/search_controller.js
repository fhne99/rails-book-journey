// app/javascript/controllers/search_controller.js
import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['query', 'results']

  connect() {
    console.log('SearchController connected');
  }
}
