class CreateXpaths < ActiveRecord::Migration
  def change
    create_table :xpaths do |t|
      t.string :retailer, :null => false
      t.string :xpath, :null => false

      t.timestamps
    end
  end
end
