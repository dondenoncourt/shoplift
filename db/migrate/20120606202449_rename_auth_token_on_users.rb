class RenameAuthTokenOnUsers < ActiveRecord::Migration
  def up
    rename_column :users, :authentication_token, :api_token
    add_index :users, :api_token, :unique => true
  end

  def down
    remove_index :users, :api_token
    rename_column :users, :api_token, :authentication_token
  end
end
