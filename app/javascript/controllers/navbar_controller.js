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
    const navbarBodyID = event.params.body;
    const navbar_body = document.getElementById(navbarBodyID);
    navbar_body.classList.toggle('hidden');
  }
}
