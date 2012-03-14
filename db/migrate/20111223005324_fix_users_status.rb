class FixUsersStatus < ActiveRecord::Migration
  def up
    change_column(:users, :status, :integer, :null => false, :default => 1)
  end

  def down
    change_column(:users, :status, :boolean, :null => false, :default => 1)
  end
end
