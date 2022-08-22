class QuickTweet < ApplicationRecord
  attr_accessor :skip_validations
  attribute :draft, default: true

  validates_with ContentLengthValidator, :minimum=> 10, :maximum=> 1750, :word_count=>3, unless: :skip_validations
  validates :body, presence: true, length: { minimum: 10, maximum: 1000 }, unless: :skip_validations
  validates :body, uniqueness: true

  before_save :purify

  after_create_commit -> {
    broadcast_prepend_to :quick_tweets, target: "quick_tweets", locals: { quick_tweets: :quick_tweets }
    #                      turbo_stream_from          with be replace by this            with this id             using these values
  }

  default_scope { order(created_at: :desc) }

  scope :published, -> { where(draft: false) }

  after_save_commit -> {
    if self.body.present?
      if (self.previous_changes.has_key?(:body) and not self.draft?) or self.previous_changes.has_key?(:draft)
        self.generate_og_image
      end
    end
  }

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :user, optional: true
  has_one_attached :image, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  def should_generate_new_friendly_id?
    true
  end

  def pure_text
    Nokogiri::HTML(body).xpath('//text()').map(&:text).join('').
      strip
  end
  def purify
    self.body = ApplicationController.helpers.purify self.body
  end
  def title
    Nokogiri::HTML(self.body).xpath('//text()').map(&:text).join(' ').truncate(100)
  end

  def excerpt
    Nokogiri::HTML(self.body).xpath('//text()').map(&:text).join(' ').truncate(300)
  end

  def generate_og_image
    image_file_io, image_name = ApplicationController.helpers.create_og_image(self.title)
    self.image.attach(io: image_file_io, filename: image_name, content_type: 'image/png')
  end
  def reading_time
    words_per_minute = 150
    text = Nokogiri::HTML(self.body).at('body').inner_text
    (text.scan(/\w+/).length / words_per_minute).to_i
  end
end


