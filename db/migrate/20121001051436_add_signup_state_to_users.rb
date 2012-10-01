class AddSignupStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signup_state, :string
    add_index :users, :signup_state
  end
end
