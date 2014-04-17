class Item < ActiveRecord::Base
         
  validates_presence_of :title
  validates_presence_of :description
  validates_uniqueness_of :title, case_sensitive: false
  validates :price, numericality: {only_integer: true, greater_than: 0}
  
  scope :active, -> { where(active: true) }
  
  before_create do 
    self.prep_time ||= 12
  end 
  
  belongs_to :category
  has_and_belongs_to_many :orders
  
end
