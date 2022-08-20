class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :body, presence: true, length: { minimum: 2, maximum: 500 }
  has_many :likes, as: :likeable, dependent: :destroy

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  default_scope { order(created_at: :desc) }

  extend FriendlyId
  friendly_id :body, use: :slugged

  def normalize_friendly_id(string)
    super[0..12]
  end

  private
  def notify_recipient
    if self.user != commentable.user
      CommentNotification.with(comment: self, commentable: commentable).deliver_later(commentable.user)
    end
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all
  end
end