# == Schema Information
#
# Table name: string_blacklists
#
#  name       :string(60)      not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class StringBlacklist < ActiveRecord::Base

end
