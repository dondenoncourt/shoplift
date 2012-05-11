class AddRequireFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :vanity_url, :string
    add_column :users, :country, :string
    add_column :users, :zipcode, :string
    add_column :users, :missing, :string
    add_column :users, :notify_new_follower, :boolean
    add_column :users, :notify_relift, :boolean
    add_column :users, :notify_missing, :string
  end
end
