class MakeHashtagsCaseSensitive < ActiveRecord::Migration
  def up
    execute "ALTER TABLE hashtag_values DEFAULT CHARACTER SET latin1 COLLATE latin1_general_cs"
  end

  def down
    execute "ALTER TABLE hashtag_values DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci"
  end
end
