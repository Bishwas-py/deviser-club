import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  initialize() {
  }
  connect() {}
  toggleComment(event) {
    event.preventDefault()
    event.stopPropagation()
    console.log(event.target.dataset)
    const commentBodyID = event.target.dataset.commentId;
    console.log("commentBodyID: " + commentBodyID)
    const commentBody = document.getElementById(commentBodyID);
    commentBody.classList.toggle('hidden');

    console.log("this.element " + this.element)
    this.element.classList.toggle('bg-blue-300');
    this.element.classList.toggle('hover:bg-blue-400');
  }
}
