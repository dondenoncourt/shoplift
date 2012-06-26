# == Schema Information
#
# Table name: item_visits
#
#  item_id    :integer(4)      not null
#  user_id    :integer(4)      not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class ItemVisit < ActiveRecord::Base
  belongs_to :items, :conditions => "status = 1"
  belongs_to :users
end
