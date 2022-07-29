class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :body, presence: true, length: { minimum: 2, maximum: 500 }


  after_create_commit -> {
    broadcast_prepend_later_to commentable, target: "#{dom_id commentable}_comments",
                               partial:  "comments/comment",
                               locals: { user: :current_user, comment: self }
  }

end
