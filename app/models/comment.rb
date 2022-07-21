class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :quick_tweet
  validates :body, presence: true, length: { minimum: 4, maximum: 500 }

  after_create_commit -> {
    broadcast_prepend_to [quick_tweet, :comments], partial: "comments/comment", target: "#{dom_id(quick_tweet)}_comments", locals: { quick_tweet: quick_tweet, comments: :comments }
    #                      turbo_stream_from          with be replace by this            with this id             using these values
  }


  after_commit -> {
    broadcast_replace_to [quick_tweet, :comments], partial: "comments/comments_count", target: "comments_count", locals: { count: quick_tweet.comments.count }
  }
end
