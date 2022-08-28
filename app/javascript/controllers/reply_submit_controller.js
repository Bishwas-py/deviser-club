import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reply-submit"
export default class extends Controller {
  initialize() {
  }
  connect() {
  }
  toggleForWhileReplying(event) {
    event.preventDefault();
    event.stopPropagation();
    const form = document.getElementById(event.target.dataset.formId);
    form.requestSubmit();
    form.classList.toggle('hidden');
    form.querySelector("textarea").value="";
  }
}
