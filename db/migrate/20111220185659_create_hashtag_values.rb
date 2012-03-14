class CreateHashtagValues < ActiveRecord::Migration
  def up
    create_table :hashtag_values do |t|
      t.primary_key :id
      t.string :value, :null => false, :limit => 60
      t.timestamps
    end
  end

  def down
    drop_table :hashtag_values
  end
end
