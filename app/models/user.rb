class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :following_follows, class_name: "Follow", foreign_key: "user_id"
  has_many :follower_follows, class_name: "Follow", foreign_key: "f_user_id"
  has_many :followings, through: :following_follows
  has_many :followers, through: :follower_follows
  has_many :tweets, dependent: :destroy

end
