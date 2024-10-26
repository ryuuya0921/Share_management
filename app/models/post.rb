class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :category, presence: true
  validates :genre, presence: true
end
