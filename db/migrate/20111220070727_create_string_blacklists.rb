class CreateStringBlacklists < ActiveRecord::Migration
  def up
    create_table :string_blacklists, :id => false do |t|
      t.string :name, :null => false, :limit => 60
      t.timestamps
    end
    
    execute <<-SQL
      ALTER TABLE string_blacklists 
        ADD PRIMARY KEY (name) ;
    SQL
  end

  def down
    drop_table :string_blacklists
  end
end
