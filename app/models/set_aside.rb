# == Schema Information
#
# Table name: set_asides
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)      not null
#  item_id    :integer(4)      not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  status     :integer(4)      default(1), not null
#

class SetAside < ActiveRecord::Base
  require 'status'
  
  belongs_to :user, :conditions => ["users.status = 1"]
  belongs_to :item, :conditions => ["items.status = 1"]
  has_one :post, :through => :item, :conditions => ["items.status = 1"]
end
