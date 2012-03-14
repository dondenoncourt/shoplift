class CreateItems < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.primary_key :id
      t.references :user, :post, :null => false
      t.references :item, :null => true
      t.timestamps
      t.integer :status, :null => false, :default => 1
    end
    
    #add a foreign key
    execute <<-SQL
      ALTER TABLE items
        ADD CONSTRAINT fk_items_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE items
        ADD CONSTRAINT fk_items_posts
        FOREIGN KEY (post_id)
        REFERENCES posts(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE items
        ADD CONSTRAINT fk_items_items
        FOREIGN KEY (item_id)
        REFERENCES items(id)
    SQL
  end

  def down
    execute "ALTER TABLE items DROP FOREIGN KEY fk_items_users"
    execute "ALTER TABLE items DROP FOREIGN KEY fk_items_posts"
    execute "ALTER TABLE items DROP FOREIGN KEY fk_items_items"
    drop_table :items
  end
end