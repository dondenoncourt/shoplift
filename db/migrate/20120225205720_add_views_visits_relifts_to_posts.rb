class AddViewsVisitsReliftsToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :views, :integer, :null => false, :default => 0
    add_column :posts, :visits, :integer, :null => false, :default => 0
    add_column :posts, :relifts, :integer, :null => false, :default => 0
  end
  
  def down
    remove_column :posts, :views
    remove_column :posts, :visits
    remove_column :posts, :relifts
  end
end
