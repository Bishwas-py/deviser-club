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
    let rs = form.requestSubmit();
    console.log(rs)
    form.classList.toggle('hidden');
    form.querySelector("textarea").value="";
  }
}
