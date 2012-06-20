class AddBrandIdToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :brand_id, :integer, :null => true
    execute <<-SQL
      insert into brands (name) select distinct(brand) from posts where brand <> ''
    SQL
    execute <<-SQL
      update posts set brand_id = 
          (select id from brands where brands.name = posts.brand limit 1 )
      where posts.brand <> ''
    SQL
    remove_column :posts, :brand
  end

  def down
    remove_column :posts, :brand_id
  end
end
