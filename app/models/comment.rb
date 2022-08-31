class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id, dependent: :nullify

  validates :body, presence: true, length: { minimum: 2, maximum: 500 }
  has_many :likes, as: :likeable, dependent: :destroy

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications

  has_noticed_notifications model_name: 'Notification'

  default_scope { order(created_at: :desc) }

  extend FriendlyId
  friendly_id :body, use: :slugged

  has_one :trash, as: :trashable, dependent: :destroy

  scope :untrashed, -> { where.missing(:trash) }
  scope :trashed, -> { where.associated(:trash) }

  def is_trashed
    not self.trash.nil?
  end

  def untrash_it
    self.trash.destroy
  end

  def trash_it
    Trash.create(trashable: self, user: self.user)
    self.cleanup_notifications
  end

  def normalize_friendly_id(string)
    super[0..12]
  end

  def title
    self.body.truncate(100)
  end

  def hash_id
    Digest::SHA1.hexdigest(self.id.to_s)
  end

  private

  def notify_recipient
    if self.parent_id.nil?
      if self.user != commentable.user
        CommentNotification.with(comment: self, commentable: commentable).deliver_later(commentable.user)
      end
    else
      commenter_equals_parent_commenter = self.user == self.parent.user
      unless commenter_equals_parent_commenter
        ReplyNotification.with(comment: self, commentable: commentable).deliver_later(self.parent.user)
      end

      commenter_equals_with_author = self.user == commentable.user
      unless commenter_equals_with_author
        CommentNotification.with(comment: self, commentable: commentable).deliver_later(commentable.user)
      end
    end
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all
  end

end