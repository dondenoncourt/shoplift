# Require fixtures
require 'active_record/fixtures'

# Set tables (order matters for dependencies)
tables = ["subscriptions","set_asides","post_flags","hashtag_flags","flag_types","hashtags",
          "hashtag_values","item_visits","items","posts","roles_users","users","brands"]

# Tables you don't want deleted
skip_delete_tables = []

# Special deletes (fk)
special_deletes = ["items"]

# Set one time load tables
load_once_tables = ["string_blacklists", "username_blacklists","roles"]

# Clear out all the current data
(tables - skip_delete_tables).each do |table_name|
  if special_deletes.index(table_name).nil?
    table_name.classify.constantize.delete_all
  else
    table_name.classify.constantize.all.reverse.each do |row|
      row.delete
    end
  end
end

# Reverse for adding
tables = tables.reverse

# Check if load once tables exists, if they do then add to tables array
load_once_tables.each do |table_name|
  if table_name.classify.constantize.all.empty?
    tables.push(table_name)
  end
end

tables.each do |table_name|
  if FileTest.exists?("#{Rails.root}/spec/fixtures/#{table_name}.yml")
    begin
        ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/spec/fixtures",table_name)
    rescue Exception => exc
        puts "#{Rails.root}/spec/fixtures/#{table_name}.yml #{exc.message}"
    end
  end
end
