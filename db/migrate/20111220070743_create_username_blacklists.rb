class CreateUsernameBlacklists < ActiveRecord::Migration
  def up
    create_table :username_blacklists, :id => false do |t|
      t.string :name, :null => false, :limit => 60
      t.timestamps
    end
    
    execute <<-SQL
      ALTER TABLE username_blacklists 
        ADD PRIMARY KEY (name) ;
    SQL
  end

  def down
    drop_table :username_blacklists
  end
end
