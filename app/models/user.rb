class User < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  enum sex: { 男性: 1, 女性: 2}

  validates :name, presence: true, length: { maximum: 50 }
  validates :full_name, presence: true, length: { maximum: 50 }
  validates :accepted, presence: { message: 'を入力してください' }

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
      uid:      auth.uid,
      provider: auth.provider,
      email:    User.dummy_email(auth),
      name: auth.info.name,
      full_name: auth.info.name,
      password: Devise.friendly_token[0, 20],
      accepted: true
      )
    end

    user
  end

  #ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  #ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  #ユーザーのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  private

    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end
