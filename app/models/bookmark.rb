# frozen_string_literal: true

class Bookmark < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[bookmarkable_id bookmarkable_type] }
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  default_scope { order(created_at: :desc) }
end
