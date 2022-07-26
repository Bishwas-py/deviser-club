import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-auth"
export default class extends Controller {
  static targets = ['delete']
  connect(event) {
    let current_user_id = document.querySelector('meta[name="current-usr-id"]').content
    let uid = this.data.get("uid");
    if (uid ===  current_user_id) {
      this.deleteTarget.classList.toggle('hidden');
    }
  }
}
