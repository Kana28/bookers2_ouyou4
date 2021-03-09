class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  # フォロー取得
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロワー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

# (自分がフォローしているユーザーと自分をフォローしているユーザーを簡単に取得するためにthroughを使った関連付け)
  # 自分をフォローしている人
  has_many :follower_user, through: :followed, source: :follower
  # 自分がフォローしている人
  has_many :following_user, through: :follower, source: :followed


  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end


  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す（既にフォローしているかの確認）
  def following?(user)
    following_user.include?(user)
  end


  attachment :profile_image, destroy: false

  validates :name,
  uniqueness: true,
  length: {maximum: 20, minimum: 2}

  validates :introduction,
  length: { maximum: 50 }

end