class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string, { :null => false, :limit => 110 }
    add_column :users, :username, :string, { :null => false, :limit => 40 }
    add_column :users, :sex, :boolean, { :null => true }
    add_column :users, :biography, :string, { :null => true, :limit => 110 }
    add_column :users, :url, :text, { :null => true }
    add_column :users, :hometown, :string, { :null => true, :limit => 110 }
    add_column :users, :birthdate, :date, { :null => true }
    add_column :users, :private, :boolean, { :null => false, :default => false }
    add_column :users, :status, :boolean, { :null => false, :default => true }
  end
end
