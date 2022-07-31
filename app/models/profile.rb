class Profile < ApplicationRecord
  belongs_to :user, :foreign_key => 'user_id'
  validates_uniqueness_of :user_id, message: "Can not have more than one profiles"

end
