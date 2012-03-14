class CreateSubscriptions < ActiveRecord::Migration
  def up
    create_table :subscriptions do |t|
      t.primary_key :id
      t.references :user,:follower, :null => false
      t.timestamps
      t.integer :status, :null => false, :default => 1
    end
    
    #add a foreign key
    execute <<-SQL
      ALTER TABLE subscriptions
        ADD CONSTRAINT fk_subscriptions_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
    
    execute <<-SQL
      ALTER TABLE subscriptions
        ADD CONSTRAINT fk_subscriptions_followers
        FOREIGN KEY (follower_id)
        REFERENCES users(id)
    SQL
  end

  def down
    execute "ALTER TABLE subscriptions DROP FOREIGN KEY fk_subscriptions_followers"
    execute "ALTER TABLE subscriptions DROP FOREIGN KEY fk_subscriptions_users"
    drop_table :subscriptions
  end
end
