class PlazaPost < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: { message: 'タイトルを入力してください' },
                    length: { maximum: 20, message: 'タイトルは20文字以内で設定してください。' }
  validates :content, presence: { message: '内容を入力してください' },
                      length: { maximum: 100, message: '内容は100文字以内で設定してください。' }
end
