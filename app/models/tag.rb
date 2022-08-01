class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  belongs_to :tagable, polymorphic: true, optional: true
end
