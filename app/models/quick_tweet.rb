class QuickTweet < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :content, presence: true, length: { minimum: 10, maximum: 1000 }, uniqueness: true
  belongs_to :user, optional: true
  has_one_attached :image, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  default_scope { order(created_at: :desc) }

  def title
    ActionController::Base.helpers.strip_tags(self.content).truncate(38)
  end

  def excerpt
    ActionController::Base.helpers.strip_tags(self.content).truncate(300)
  end
  after_create_commit -> {
    broadcast_prepend_to :quick_tweets, target: "quick_tweets", locals: { quick_tweets: :quick_tweets }
    #                      turbo_stream_from          with be replace by this            with this id             using these values
  }

end


