class CreateItemVisits < ActiveRecord::Migration
  def up
    create_table :item_visits, :id => false do |t|
      t.references :item, :user, :null => false
      t.timestamps
    end
    
    execute <<-SQL
      ALTER TABLE item_visits
        ADD CONSTRAINT fk_item_visits_items
        FOREIGN KEY (item_id)
        REFERENCES items(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE item_visits
        ADD CONSTRAINT fk_item_visits_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
    
  end

  def down
    execute "ALTER TABLE item_visits DROP FOREIGN KEY fk_item_visits_users"
    execute "ALTER TABLE item_visits DROP FOREIGN KEY fk_item_visits_items"
    drop_table :item_visits
  end
end
