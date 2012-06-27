class Brand < ActiveRecord::Base
  validates :name, presence: true
end
# == Schema Information
#
# Table name: brands
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  reviewed   :boolean(1)      default(FALSE), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

