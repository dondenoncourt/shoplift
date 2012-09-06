class CreateUserItemViews < ActiveRecord::Migration
  def change
    create_table :user_item_views do |t|
      t.integer :user_id
      t.integer :item_id
      t.datetime :created_at
    end
    add_index :user_item_views, [:user_id, :item_id]
    add_index :user_item_views, :user_id
    add_index :user_item_views, :item_id
  end
end
