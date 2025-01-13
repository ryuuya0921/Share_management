class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :plaza_post
  acts_as_votable

  validates :content, presence: { message: 'コメント内容を入力してください' }
end
