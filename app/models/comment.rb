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

  after_create_commit -> {
    broadcast_prepend_to commentable, :comments, target: "#{dom_id commentable}_comments",
                               partial:  "comments/broadcast_comment",
                               locals: { comment: self }
  #  pushed to this listener: turbo_stream_from commentable, :comments
  }

  after_commit -> {
    broadcast_replace_to commentable, :comments, partial: "comments/comments_count", target: "comments_count_bottom", locals: { count: commentable.comments.count }
  }

  private
  def notify_recipient
    CommentNotification.with(comment: self, commentable: commentable).deliver_later(commentable.user)
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all
  end
end