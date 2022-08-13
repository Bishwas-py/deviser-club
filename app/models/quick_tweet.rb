class QuickTweet < ApplicationRecord

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :content, presence: true, length: { minimum: 10, maximum: 1000 }, uniqueness: true
  belongs_to :user, optional: true
  has_one_attached :image, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  default_scope { order(created_at: :desc) }

  before_save -> {
    self.generate_og_image
  }
  after_create_commit -> {
    broadcast_prepend_to :quick_tweets, target: "quick_tweets", locals: { quick_tweets: :quick_tweets }
    #                      turbo_stream_from          with be replace by this            with this id             using these values
  }

  def title
    Nokogiri::HTML(self.content).xpath('//text()').map(&:text).join(' ').truncate(100)
  end

  def generate_og_image
    image_file_io, image_name = ApplicationController.helpers.create_og_image(self.title)
    self.image.attach(io: image_file_io, filename: image_name, content_type: 'image/png')
  end

  def excerpt
    Nokogiri::HTML(self.content).xpath('//text()').map(&:text).join(' ').truncate(300)
  end
end


