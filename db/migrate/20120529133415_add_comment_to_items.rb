class AddCommentToItems < ActiveRecord::Migration
  def change
    add_column :items, :comment, :string, :limit => 100
  end
end
