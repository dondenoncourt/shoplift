class FixItemVisitUserNotNull < ActiveRecord::Migration
  def up
    change_column(:item_visits, :user_id, :integer, :null => true)
  end

  def down
    change_column(:item_visits, :user_id, :integer, :null => false)
  end
end
