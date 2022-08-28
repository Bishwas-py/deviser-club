class QuickTweet < ApplicationRecord
  include ActiveModel::Validations

  attr_accessor :skip_validations

  validates_with ContentLengthValidator, :minimum => 10, :maximum => 1750, :word_count => 3, unless: :skip_validations
  validates :body, presence: true, length: { minimum: 10, maximum: 1000 }, unless: :skip_validations
  validates :body, uniqueness: { scope: :user_id }

  belongs_to :user, optional: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  has_one :draft, as: :draftable, dependent: :destroy

  before_save :purify

  scope :published, -> { where.missing(:draft) }
  scope :unpublished, -> { where.associated(:draft) }

  def is_published
    self.draft.nil?
  end

  def publish
    self.draft = nil
    self.save
  end

  def unpublish
    self.draft.save
  end

  default_scope { order(created_at: :desc) }

  after_save_commit -> {
    if self.body.present? and self.previous_changes.has_key?(:body)
      self.generate_og_image
    end
  }

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


