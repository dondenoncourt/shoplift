class AddHashtagCountToHashtagValue < ActiveRecord::Migration
  def up
    add_column :hashtag_values, :hashtags_count, :int, :default => 0

    HashtagValue.reset_column_information
    HashtagValue.find(:all).each do |hv|
      HashtagValue.reset_counters hv.id, :hashtags
    end
  end
  def down
    remove_column :hashtag_values, :hashtags_count
  end
end
