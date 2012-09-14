class CreateHashtagbrands < ActiveRecord::Migration
  def self.up
    create_table :hashtagbrands do |t|
      t.references :brand
      t.references :hashtag

      t.timestamps
    end
    add_index :hashtagbrands, :hashtag_id

    execute <<-SQL
      insert into hashtagbrands (brand_id) select id from brands;
    SQL
    execute <<-SQL
      insert into hashtagbrands (hashtag_id) select id from hashtags;
    SQL
  end
  def self.down
    drop_table :hashtagbrands
  end
end
