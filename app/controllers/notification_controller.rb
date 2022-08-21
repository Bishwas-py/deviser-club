class NotificationController < ApplicationController
  def index
    @pagy, @notifications = pagy(Notification.where(recipient: current_user).newest_first.unread, items: 2)
  end

  def read
    @pagy, @notifications = pagy(Notification.where(recipient: current_user).newest_first.read, items: 2)
    render(:template => "notification/index")
  end

  def all
    @pagy, @notifications = pagy(Notification.where(recipient: current_user).newest_first.all, items: 2)
    render(:template => "notification/index")
  end
end
