class Category < ActiveRecord::Base
  
   validates_presence_of :title
  
   has_many :items
  
end
