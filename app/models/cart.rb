class Cart 
  
  def initialize(session)
    @session = session
    @session[:item_ids] ||= []
  end 
  
  def add_item(item)
    @session[:item_ids] << item.id
  end 
  
  def remove_item(item)
    @session[:item_ids].delete(item.id)
  end 
  
  def items
    #item_ids.collect { |i| Item.find(i) }
    Item.where :id => item_ids
  end
  
  def items_count
    @session[:item_ids].size
  end
  
  def item_ids
    @session[:item_ids]
  end
  
  def empty?
    @session[:item_ids].empty?
  end 
  
  def empty!
    @session[:item_ids] = []
  end
  
  def calculate_earliest_pickup_at
    @calculate_earliest_pickup_at ||= Order.calculate_earliest_pickup_at(items)
  end 
  
end
