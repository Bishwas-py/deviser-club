import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-auth"
export default class extends Controller {
  static targets = ['delete']
  connect(event) {
    let current_user_id = document.querySelector('input[name="current-usr-id"]').value
    let uid = this.data.get("uid");
    if (uid ===  current_user_id) {
      this.deleteTarget.classList.toggle('hidden');
    }
  }
}
