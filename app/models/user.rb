class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]
  after_save :create_profile

  has_many :notifications, as: :recipient, dependent: :destroy

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  has_many :comments, dependent: :destroy
  has_many :quick_tweets, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :drafts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_one :profile
  has_many :tags, foreign_key: :created_by_id, dependent: :destroy
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  attr_writer :login
  def login
    @login || self.username || self.email
  end

  extend FriendlyId
  friendly_id :username, use: :slugged

  def create_profile
    Profile.create(user: self)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end