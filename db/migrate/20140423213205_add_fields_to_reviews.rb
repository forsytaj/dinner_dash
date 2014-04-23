class AddFieldsToReviews < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.string :title
      t.text :body
      t.integer :rating, default: 1
      t.references :user, :item
    end 
  end
end
