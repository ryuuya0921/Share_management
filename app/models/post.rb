class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  paginates_per 9
  acts_as_votable
  has_many :comments, dependent: :destroy

  attr_accessor :remove_image

  validates :title, presence: true
  validates :category, presence: true
  validates :genre, presence: true

  before_save :purge_image, if: -> { remove_image == '1' }

  private

  def purge_image
    image.purge
  end
end
