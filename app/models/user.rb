class User < ActiveRecord::Base
  
  has_many :orders
  has_secure_password
  
  attr_accessible :email, :password, :password_confirmation
  
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
end
