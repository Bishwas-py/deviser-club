class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'


  private
  def notify_recipient
    if self.user != likeable.user
      LikeNotification.with(like: self, likeable: likeable).deliver_later(likeable.user)
    end
  end

  def cleanup_notifications
    notifications_as_like.destroy_all
  end

end
