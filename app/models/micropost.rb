class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  has_many :microposts
  has_many :favorites
  
  #お気に入り
  def favorite_feed
    # if params[]
    # ravorites.find_or_create_by(user_id: micropost_id )
    #redirect_to root_path
  end
end
