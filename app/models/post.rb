# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, length: { minimum: 4, maximum: 500 }
  validates :body,  length: { minimum: 70, maximum: 99_889 }
  belongs_to :user, optional: false

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables

  has_one_attached :image, dependent: :destroy

  extend FriendlyId
  friendly_id :title, use: :slugged

  default_scope { order(created_at: :desc) }

  def excerpt
    Nokogiri::HTML(body).xpath('//text()').map(&:text).join(' ').truncate(300)
  end

  def reading_time
    words_per_minute = 150
    text = Nokogiri::HTML(body).at('body').inner_text
    (text.scan(/\w+/).length / words_per_minute).to_i
  end

  def similiar_posts
    Post.joins(:tags) # You need to query the Post table
        .where.not(posts: { id: id }) # Exclude this post
        .where(tags: { id: tags.ids }) # Get similar tags
        .group(:id)
  end
end
