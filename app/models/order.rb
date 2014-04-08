class Order < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :items
  
  validates_presence_of :user_id
  validate :minimum_items_count
  
  scope :with_status, -> (status) { where(order_status: status)}
  
  before_create do
    self.pickup_at ||= Time.zone.now + 15.minutes
    self.order_status = Order.order_statuses.first
  end 
  
  def minimum_items_count
    errors.add(:items, "must have at least one") unless items.size > 0
  end 
  
  def self.order_statuses
    ['ordered', 'paid', 'cancelled', 'completed']
  end 
  
  def self.order_statuses_for_select
    order_statuses.collect { |o| [o.humanize, o] }.unshift(['Show All', ''])
  end 
  
end
