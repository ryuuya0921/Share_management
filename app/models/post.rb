class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  paginates_per 9
  acts_as_votable

  validates :title, presence: true
  validates :category, presence: true
  validates :genre, presence: true
end
