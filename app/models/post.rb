class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  paginates_per 9

  validates :title, presence: true
  validates :category, presence: true
  validates :genre, presence: true
end
