class Order < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :items
  
  validates_presence_of :user_id
  validate :minimum_items_count
  validate :earliest_pickup_at
  validate :open_for_business
  
  scope :with_status, -> (status) { where(order_status: status)}
  
  before_validation(on: :create) do
    self.pickup_at ||= Time.zone.now + 15.minutes
    self.order_status = Order.order_statuses.first
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
  
  def calculate_earliest_pickup_at
    @calculate_earliest_pickup_at ||= Order.calculate_earliest_pickup_at(items)
  end 
  
  def self.order_statuses
    ['ordered', 'paid', 'cancelled', 'completed']
  end 
  
  def self.order_statuses_for_select
    order_statuses.collect { |o| [o.humanize, o] }.unshift(['Show All', ''])
  end 
    
  def self.calculate_earliest_pickup_at(items)
      time = Time.zone.now
      #Each item in the store has a preparation time, defaulting to 12 minutes. Items can be edited to take longer.
      #The kitchen can prepare only one item at a time.
      time += items.sum(:prep_time).minutes
      #If an order has more than six items, add 10 minutes for every additional six items.
      time += ((items.count / 6) * 10).minutes
      #Each already "paid" order in the system which is not "complete" delays the production start of this new order by 4 minutes.
      time += (Order.with_status('paid').count * 4).minutes
      time
  end 
  
end
