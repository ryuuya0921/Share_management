class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :plaza_post
end
