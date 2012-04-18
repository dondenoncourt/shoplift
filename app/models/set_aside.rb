class SetAside < ActiveRecord::Base
  require 'status'
  
  belongs_to :user, :conditions => ["users.status = 1"]
  belongs_to :item, :conditions => ["items.status = 1"]
  has_one :post, :through => :item, :conditions => ["items.status = 1"]
end