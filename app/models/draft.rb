class Draft < ApplicationRecord
  validates :draftable_id, uniqueness: { scope: :draftable_type }
  belongs_to :user
  belongs_to :draftable, polymorphic: true
end
