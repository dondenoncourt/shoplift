class CreateCategoryHashtags < ActiveRecord::Migration
  def change
    create_table :category_hashtag_values do |t|
      t.integer :category_id
      t.integer :hashtag_value_id

      t.timestamps
    end
  end
end
