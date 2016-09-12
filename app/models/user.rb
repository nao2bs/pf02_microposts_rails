class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  #最大１０文字
  validates :location, presence: true, length: { maximum: 10 }
  has_secure_password
  
  has_many :microposts
  
  
  has_many :following_relationships, class_name: "Relationship",
                                     foreign_key: "follower_id",
                                     dependent: :destroy
  has_many :following_users ,through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name: "Relationship",
                                     foreign_key: "followed_id",
                                     dependent: :destroy
  
  has_many :follower_users ,through: :follower_relationships, source: :follower
  
  
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: :micropost
  #他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  
  #フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end
  
  #あるユーザーをフォローしているかどうか
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  #フィードの表示
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  
  #kaminari設定
  paginates_per 10
  
  def favorite(micropost)
    favorites.find_or_create_by(micropost_id: micropost.id)
  end
  
  def favorite?(micropost)
    favorite_posts.include?(micropost)
  end
  
  def delete_favorite(micropost)
    favorites = favorites.find_by(micropost_id: micropost.id)
    favorites.destroy if favorites
  end
end
