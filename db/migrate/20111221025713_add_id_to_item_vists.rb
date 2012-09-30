class AddIdToItemVists < ActiveRecord::Migration
  def change
    add_column :item_visits, :id, :primary_key
  end
end
