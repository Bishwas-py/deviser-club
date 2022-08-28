class Trash < ApplicationRecord
  validates :trashable_id, uniqueness: { scope: :trashable_type }
  belongs_to :user
  belongs_to :trashable, polymorphic: true
end
