class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :posts, dependent: :destroy # ユーザーが削除されたら投稿も削除される
  has_many :plaza_posts, dependent: :destroy # これにより、ユーザーが削除されるとその投稿も削除される
  has_many :comments, dependent: :destroy

  # フォローしているユーザー
  has_many :active_follows, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_follows, source: :followed

  # フォロワー
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

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

  # フォローする
  def follow(other_user)
    following << other_user unless self == other_user || following.include?(other_user)
  end

  # フォロー解除
  def unfollow(other_user)
    following.delete(other_user)
  end

  # フォローしているか確認
  def following?(other_user)
    following.include?(other_user)
  end

  private

  def purge_profile_image
    profile_image.purge
  end
end
