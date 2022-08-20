class NotificationController < ApplicationController
  def index
    @unread_comment_notification = Notification.where(recipient: current_user, type: :CommentNotification).newest_first.limit(9).unread

    @unread = Notification.where(recipient: current_user).newest_first.limit(9).unread
  end
end
