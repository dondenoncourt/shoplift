# == Schema Information
#
# Table name: item_visits
#
#  item_id    :integer(4)      not null
#  user_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  id         :integer(4)      not null, primary key
#

class ItemVisit < ActiveRecord::Base
  belongs_to :items, :conditions => "status = 1"
  belongs_to :users
end
