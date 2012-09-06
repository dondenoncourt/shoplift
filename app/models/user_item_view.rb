# == Schema Information
#
# Table name: user_item_views
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  item_id    :integer(4)
#  created_at :datetime
#

class UserItemView < ActiveRecord::Base
end
