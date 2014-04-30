class AddSaleIdToItemRemoveSalesId < ActiveRecord::Migration
  def change
    remove_column :items, :sales_id, :integer
    
    add_column :items, :sale_id, :integer
  end
end
