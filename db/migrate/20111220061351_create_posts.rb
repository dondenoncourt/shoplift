class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.primary_key :id
      t.string :name, :null => false, :limit => 110 
      t.text :description, :null => false
      t.string :brand, :null => false
      t.string :retailer, :null => false
      t.string :url, :null => false, :limit => 2083
      t.decimal :price, :null => true
      t.boolean :hashtags_allowed, :null => false, :default => 1
      t.string :comment, :null => true, :limit => 100
      t.references :user, :null => false
      t.timestamps
      t.integer :status, :null => false, :default => 1
    end
    
    #add a foreign key
    execute <<-SQL
      ALTER TABLE posts
        ADD CONSTRAINT fk_posts_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
  end

  def down
    execute "ALTER TABLE posts DROP FOREIGN KEY fk_posts_users"
    drop_table :posts
  end
end