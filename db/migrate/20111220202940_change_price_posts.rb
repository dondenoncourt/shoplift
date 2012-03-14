class ChangePricePosts < ActiveRecord::Migration
  def up
    change_column :posts, :price, :decimal, { :scale => 2, :precision => 10 }
  end

  def down
    change_column :posts, :price, :decimal
  end
end
