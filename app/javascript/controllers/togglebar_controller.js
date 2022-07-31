import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quick-tweet"
export default class extends Controller {
  connect() {
    console.log('navbar');
  }
  initialize() {
  }
  toggleNavDrop(event) {
    event.preventDefault()
    event.stopPropagation()
    const toogleBarBodyID = event.params.body;
    const togglebar_body = document.getElementById(toogleBarBodyID);
    togglebar_body.classList.toggle('hidden');
  }
}
