import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ring-notification"
export default class extends Controller {
  connect() {
    let commentNotificationId = this.data.get("comment-notification-id")
    let current_user_id = document.querySelector('input[name="current-usr-id"]').value
    let comment_uid = this.data.get("comment-uid")
    console.log(comment_uid, current_user_id);
    if (comment_uid !== current_user_id) {
      document.querySelector(commentNotificationId).play()
    }
  }
}
