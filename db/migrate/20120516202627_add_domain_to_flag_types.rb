class AddDomainToFlagTypes < ActiveRecord::Migration
  def change
    add_column :flag_types, :domain_name, :string
  end
end
