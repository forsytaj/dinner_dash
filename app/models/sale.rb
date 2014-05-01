class Sale < ActiveRecord::Base
  
  has_many :items
  
  validates_presence_of :discount
  validates_presence_of :title
  validates :discount, numericality: {only_integer: true, greater_than: 0}
  
end
