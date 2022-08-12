# frozen_string_literal: true

class Taggable < ApplicationRecord
  belongs_to :post
  belongs_to :tag
end
