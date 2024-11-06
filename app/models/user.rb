class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :posts, dependent: :destroy # ユーザーが削除されたら投稿も削除される
  has_many :comments, dependent: :destroy # ユーザーが削除されたらコメントも削除される
  acts_as_voter

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def guest?
    email == 'guest@example.com'
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
    end
  end

  # ActiveStorageを使用してプロフィール画像を紐付け
  has_one_attached :profile_image

  validates :name, presence: true # 名前のバリデーション
  validates :bio, length: { maximum: 200 } # 自己紹介の文字数制限を設定

  attr_accessor :remove_profile_image

  before_save :purge_profile_image, if: -> { remove_profile_image == '1' }

  private

  def purge_profile_image
    profile_image.purge
  end
end
