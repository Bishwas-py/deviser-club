class NotificationController < ApplicationController
  def index
    @pagy, @notifications = pagy(Notification.where(recipient: current_user).newest_first.unread, items: 2)
  end
end
