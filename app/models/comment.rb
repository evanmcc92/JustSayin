class Comment < ActiveRecord::Base
  attr_accessible :comment

  belongs_to :user
  belongs_to :micropost
  
  default_scope :order => 'comments.created_at DESC'
  
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :comment, presence: true, length: { maximum: 140 }
end
