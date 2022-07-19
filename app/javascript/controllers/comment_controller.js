import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  initialize() {
  }
  connect() {}
  toggleComment(event) {
    event.preventDefault()
    event.stopPropagation()
    const commentBodyID = event.params.body;
    const commentBody = document.getElementById(commentBodyID);
    commentBody.classList.toggle('hidden');
  }
}
