class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :quick_tweet
  belongs_to :user
  validates :body, presence: true, length: { minimum: 4, maximum: 500 }
end
