class CreateFlagTypes < ActiveRecord::Migration
  def up
    create_table :flag_types do |t|
      t.primary_key :id
      t.string :name, :null => false, :limit => 60
      t.timestamps
    end
    
  end
  
  def down
    drop_table :flag_types
  end
end