class AddFollowersCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :count_of_followers, :integer, :default => 0
  end
end
