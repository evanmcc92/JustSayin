class Comment < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :micropost
  
  default_scope :order => 'comments.created_at'
  
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end
end
