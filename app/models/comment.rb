class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :body, presence: true, length: { minimum: 4, maximum: 500 }
end
