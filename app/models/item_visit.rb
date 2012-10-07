class ItemVisit < ActiveRecord::Base
  belongs_to :items, :conditions => "status = 1"
  belongs_to :users
end
