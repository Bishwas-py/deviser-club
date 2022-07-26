class Post < ApplicationRecord
  validates :title,  length: { minimum: 4, maximum: 500 }
  validates :body,  length: { minimum: 70, maximum: 99889 }
  belongs_to :user, optional: false
end