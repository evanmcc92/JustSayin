class Micropost < ActiveRecord::Base
  attr_accessible :content, :up, :down

  belongs_to :user
  has_many :comments, :dependent => :destroy 
  
  default_scope :order => 'microposts.created_at DESC'
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :up, presence: true
  validates :down, presence: true


  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end
end
