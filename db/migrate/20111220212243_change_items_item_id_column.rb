class ChangeItemsItemIdColumn < ActiveRecord::Migration
  def up
    execute "ALTER TABLE items DROP FOREIGN KEY fk_items_items"
    rename_column :items, :item_id, :parent_id
    
    execute <<-SQL
      ALTER TABLE items
        ADD CONSTRAINT fk_items_parents
        FOREIGN KEY (parent_id)
        REFERENCES items(id)
    SQL
  end

  def down
    execute "ALTER TABLE items DROP FOREIGN KEY fk_items_parents"
    rename_column :items, :parent_id, :item_id
    
    execute <<-SQL
      ALTER TABLE items
        ADD CONSTRAINT fk_items_items
        FOREIGN KEY (item_id)
        REFERENCES items(id)
    SQL
    
  end
end
