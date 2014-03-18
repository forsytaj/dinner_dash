class Order < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :items
  
  validates_presence_of :user_id
  validate :minimum_items_count
  
  def minimum_items_count
    errors.add(:items, "must have at least one") unless items.size > 0
  end 
  
end
