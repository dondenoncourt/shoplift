class CreateSetAsides < ActiveRecord::Migration
  def up
    create_table :set_asides do |t|
      t.primary_key :id
      t.references :user, :item, :null => false
      t.timestamps
      t.integer :status, :null => false, :default => 1
    end
    
    execute <<-SQL
      ALTER TABLE set_asides
        ADD CONSTRAINT fk_set_asides_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE set_asides
        ADD CONSTRAINT fk_set_asides_items
        FOREIGN KEY (item_id)
        REFERENCES items(id)
    SQL
  end

  def down
    execute "ALTER TABLE set_asides DROP FOREIGN KEY fk_set_asides_users"
    execute "ALTER TABLE set_asides DROP FOREIGN KEY fk_set_asides_items"
    drop_table :set_asides
  end
end
