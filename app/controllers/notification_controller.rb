class NotificationController < ApplicationController
  def index
    @pagy, @notifications = pagy(Notification.where(recipient: current_user).newest_first.all, items: 12)

  end

  def read
    @pagy, @notifications = pagy(Notification.where(recipient: current_user).newest_first.read, items: 12)
    render(:template => "notification/index")
  end

  def unread
    @pagy, @notifications = pagy(Notification.where(recipient: current_user).newest_first.unread, items: 12)
    render(:template => "notification/index")
  end

  def mark_read
    @notification = Notification.find_by(recipient: current_user, id: params[:id])
    @notification.mark_as_read!
    respond_to do |format|
      format.turbo_stream if request.method == "POST"
    end
  end
end
