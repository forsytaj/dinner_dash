class AddPhotosToItems < ActiveRecord::Migration
  def change
    change_table :items do |t|
        t.string :photo
    end 
  end
end
