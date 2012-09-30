class CreateHashtagFlags < ActiveRecord::Migration
  def up
    create_table :hashtag_flags do |t|
      t.primary_key :id
      t.integer :flag_type_id, :null => false
      t.integer :hashtag_id, :null => false
      t.integer :user_id, :null => false
      t.timestamps
      t.integer :status, :null => false, :default => 1
    end
    
    execute <<-SQL
      ALTER TABLE hashtag_flags
        ADD CONSTRAINT fk_hashtag_flags_hashtags
        FOREIGN KEY (hashtag_id)
        REFERENCES hashtags(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE hashtag_flags
        ADD CONSTRAINT fk_hashtag_flags_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE hashtag_flags
        ADD CONSTRAINT fk_hashtag_flags_flag_types
        FOREIGN KEY (flag_type_id)
        REFERENCES flag_types(id)
    SQL
    
  end

  def down
    execute "ALTER TABLE hashtag_flags DROP FOREIGN KEY fk_hashtag_flags_hashtags"
    execute "ALTER TABLE hashtag_flags DROP FOREIGN KEY fk_hashtag_flags_flag_types"
    execute "ALTER TABLE hashtag_flags DROP FOREIGN KEY fk_hashtag_flags_users"
    drop_table :hashtag_flags
  end
end
