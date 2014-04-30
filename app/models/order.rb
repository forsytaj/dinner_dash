class Order < ActiveRecord::Base
  
  include ItemCalculation
  
  belongs_to :user
  has_and_belongs_to_many :items
  
  validates_presence_of :user_id
  validate :minimum_items_count
  validate :earliest_pickup_at
  validate :open_for_business, on: :create
  
  scope :with_status, -> (status) { where(order_status: status)}
  
  before_validation(on: :create) do
    self.pickup_at ||= Time.zone.now + 15.minutes
    self.order_status = Order.order_statuses.first
  end 

  after_create do 
    OrderMailer.new_message(self).deliver
  end 
  
  def minimum_items_count
    errors.add(:items, "must have at least one") unless items.size > 0
  end 
  
  def earliest_pickup_at
    errors.add(:pickup_at, 'must be further in the future.') if pickup_at < calculate_earliest_pickup_at
  end 
  
  def open_for_business
    unless (9..17).include?(pickup_at.hour)
      errors.add(:pickup_at, 'is while the kitchen is closed, please select a time between 9am and 5pm.')
    end
  end
  
  def self.order_statuses
    ['ordered', 'paid', 'cancelled', 'completed']
  end 
  
  def self.order_statuses_for_select
    order_statuses.collect { |o| [o.humanize, o] }.unshift(['Show All', ''])
  end 
    
 
  
end
