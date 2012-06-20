class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.boolean :reviewed, :null => false, :default => 0
      t.timestamps
    end
  end
end
