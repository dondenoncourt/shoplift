class AddCountToItem < ActiveRecord::Migration
  def up
    add_column :items, :views, :integer, :null => false, :default => 0
    add_column :items, :visits, :integer, :null => false, :default => 0
    add_column :items, :relifts, :integer, :null => false, :default => 0
  end
  
  def down
    remove_column :items, :views
    remove_column :items, :visits
    remove_column :items, :relifts
  end
end
