class CartController < ApplicationController
  
  def add
    item = Item.find(params[:item_id])
    current_cart.add_item(item) if item
    redirect_to cart_path
  end 
  
  def remove
    item = Item.find(params[:item_id])
    current_cart.remove_item(item) if item
    redirect_to cart_path
  end
  
end
