class CreateHashtags < ActiveRecord::Migration
  def up
    create_table :hashtags do |t|
      t.primary_key :id
      t.integer :hashtag_value_id, :null => false
      t.integer :post_id, :null => false
      t.integer :user_id, :null => false
      t.timestamps
      t.integer :status, :null => false, :default => 1
    end
    
    execute <<-SQL
      ALTER TABLE hashtags
        ADD CONSTRAINT fk_hashtags_posts
        FOREIGN KEY (post_id)
        REFERENCES posts(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE hashtags
        ADD CONSTRAINT fk_hashtags_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE hashtags
        ADD CONSTRAINT fk_hashtags_hashtag_values
        FOREIGN KEY (hashtag_value_id)
        REFERENCES hashtag_values(id)
    SQL
    
  end

  def down
    execute "ALTER TABLE hashtags DROP FOREIGN KEY fk_hashtags_posts"
    execute "ALTER TABLE hashtags DROP FOREIGN KEY fk_hashtags_users"
    execute "ALTER TABLE hashtags DROP FOREIGN KEY fk_hashtags_hashtag_values"
    drop_table :hashtags
  end
end
