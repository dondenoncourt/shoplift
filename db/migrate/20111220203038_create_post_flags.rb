class CreatePostFlags < ActiveRecord::Migration
  def up
    create_table :post_flags do |t|
      t.primary_key :id
      t.integer :flag_type_id, :null => false
      t.integer :post_id, :null => false
      t.integer :user_id, :null => false
      t.timestamps
      t.integer :status, :null => false, :default => 1
    end
    
    execute <<-SQL
      ALTER TABLE post_flags
        ADD CONSTRAINT fk_post_flags_posts
        FOREIGN KEY (post_id)
        REFERENCES posts(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE post_flags
        ADD CONSTRAINT fk_post_flags_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE post_flags
        ADD CONSTRAINT fk_post_flags_flag_types
        FOREIGN KEY (flag_type_id)
        REFERENCES flag_types(id)
    SQL
    
  end

  def down
    execute "ALTER TABLE post_flags DROP FOREIGN KEY fk_post_flags_posts"
    execute "ALTER TABLE post_flags DROP FOREIGN KEY fk_post_flags_flag_types"
    execute "ALTER TABLE post_flags DROP FOREIGN KEY fk_post_flags_users"
    drop_table :post_flags
  end
end
