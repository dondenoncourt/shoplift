class CreateHashtagbrands < ActiveRecord::Migration
  def self.up
    create_table :hashtagbrands do |t|
      t.references :brand
      t.references :hashtag_value

      t.timestamps
    end
    add_index :hashtagbrands, :hashtag_value_id
    add_index :hashtagbrands, :brand_id

    execute <<-SQL
      insert into hashtagbrands (brand_id) select id from brands;
    SQL
    execute <<-SQL
      insert into hashtagbrands (hashtag_value_id) select id from hashtag_values;
    SQL
  end
  def self.down
    drop_table :hashtagbrands
  end
end
