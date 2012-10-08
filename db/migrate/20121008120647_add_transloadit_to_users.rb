class AddTransloaditToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :avatar_file_name
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_updated_at
    
    add_column :users, :original_url, :string
    add_column :users, :large_url, :string
    add_column :users, :thumb_url, :string
  end
end
