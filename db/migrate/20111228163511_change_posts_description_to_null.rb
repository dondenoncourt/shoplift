class ChangePostsDescriptionToNull < ActiveRecord::Migration
  def up
    change_column :posts, :description, :text, {:null => true}
  end

  def down
    change_column :posts, :description, :text, {:null => false}
  end
end
