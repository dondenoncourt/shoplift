# == Schema Information
#
# Table name: flag_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(60)      not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class FlagType < ActiveRecord::Base

end
