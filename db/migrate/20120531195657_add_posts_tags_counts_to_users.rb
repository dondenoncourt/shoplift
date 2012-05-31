class AddPostsTagsCountsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :count_of_posts, :integer, :default => 0
    add_column :users, :count_of_hashtags, :integer, :default => 0
  end
end
