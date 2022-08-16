class Draft < ApplicationRecord
  belongs_to :user
  belongs_to :draftable
end
