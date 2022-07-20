class QuickTweet < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :content, presence: true, length: { minimum: 5, maximum: 9000 }
  validates :imagefield, presence: true

  after_create_commit -> {
    broadcast_prepend_to :quick_tweets, target: "quick_tweets", locals: { quick_tweets: :quick_tweets }
    #                      turbo_stream_from          with be replace by this            with this id             using these values
  }

end
