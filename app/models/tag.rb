class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :taggables, dependent: :destroy
  has_many :posts, through: :taggables
  belongs_to :created_by, class_name: "User"
  belongs_to :modified_by, class_name: "User", optional: true

  extend FriendlyId
  friendly_id :name, use: :slugged


  def mixed_posts
    self.posts + QuickTweet.where("body ILIKE '%#{self.name}%'")
  end

end