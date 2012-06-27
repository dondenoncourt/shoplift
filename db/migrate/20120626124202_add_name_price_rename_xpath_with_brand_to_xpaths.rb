class AddNamePriceRenameXpathWithBrandToXpaths < ActiveRecord::Migration
  def change
    rename_column :xpaths, :xpath, :brand
    change_column :xpaths, :brand, :string, :null => true
    add_column :xpaths, :name, :string, :null => true
    add_column :xpaths, :price, :string, :null => true
  end
end
