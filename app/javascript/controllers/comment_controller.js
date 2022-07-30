import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  initialize() {
  }
  connect() {
    this.element.addEventListener('click', this.toggleComment.bind(this))
  }
  toggleComment(event) {
    event.preventDefault()
    event.stopPropagation()
    const commentBodyID = "comment-box";
    const commentBody = document.getElementById(commentBodyID);
    commentBody.classList.toggle('hidden');
  }
}
