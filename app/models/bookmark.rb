class Bookmark < ApplicationRecord
  validates :user_id, uniqueness: { scope: [:bookmarkable_id, :bookmarkable_type] }
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  default_scope { order(created_at: :desc) }
end
