import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ring-notification"
export default class extends Controller {
  connect() {
    let commentNotificationId = this.data.get("comment-notification-id")
    let commentNotification = document.querySelector(commentNotificationId)
    let current_user_id = document.querySelector('meta[name="current-usr-id"]').content
    let comment_uid = this.data.get("comment-uid")

    if (comment_uid !== current_user_id) {
      commentNotification.play()
    }
  }
}
