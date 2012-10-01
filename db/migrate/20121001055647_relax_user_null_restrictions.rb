class RelaxUserNullRestrictions < ActiveRecord::Migration

  def up
    change_column :users, :full_name, :string, :null => true
  end

  def down
    change_column :users, :full_name, :string, :null => false
  end
end
