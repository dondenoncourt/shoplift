class AddPostsCount < ActiveRecord::Migration
  def up
    add_column :brands, :posts_count, :integer, :default => 0

    Brand.reset_column_information
    Brand.find(:all).each do |b|
      b.update_attribute :posts_count, b.posts.length
    end

  end

  def down
    remove_column :brands, :posts_count
  end
end
