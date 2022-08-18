class Profile < ApplicationRecord
  belongs_to :user, :foreign_key => 'user_id'
  validates_uniqueness_of :user_id, message: "Can not have more than one profiles"
  has_one_attached :avatar

  def get_name
    self.name || self.user.username
  end
  def my_avatar
    (self and self.avatar.attached?) ? self.avatar : "cute.jpg"
  end
end
