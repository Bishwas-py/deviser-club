# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  validates_uniqueness_of :user_id, message: 'Can not have more than one profiles'
  has_one_attached :avatar

  def get_name
    name || user.username
  end

  def my_avatar
    self && avatar.attached? ? avatar : 'fav.png'
  end
end
