class Review < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :item
  
  default_scope order('reviews.rating DESC')
  
  validates_presence_of :user_id, :item_id, :title, :body
  validates_inclusion_of :rating, in: 1..5
  validate :user_can_update, on: :update
  
  def user_can_update
    errors.add(:created_at, 'must be within the last 15 minutes') unless editable?
  end 
  
  def editable?
    created_at > 15.minutes.ago
  end
  
  def editable_for?(current_user)
    editable? && current_user.present? && current_user == user
  end 
  
  def self.ratings
    1..5
  end 
end
