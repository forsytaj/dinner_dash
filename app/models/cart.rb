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
    Item.find @session[:item_ids]
  end
  
  def items_count
    @session[:item_ids].size
  end
  
end
