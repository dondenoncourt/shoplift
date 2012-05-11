# == Schema Information
#
# Table name: username_blacklists
#
#  name       :string(60)      not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class UsernameBlacklist < ActiveRecord::Base
  
end
