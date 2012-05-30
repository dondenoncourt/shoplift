# == Schema Information
#
# Table name: roles
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  ADMIN = :admin
  USER = :user

  ALL_ROLES = [ADMIN, USER]

  ALL_ROLES.each do |role|
    class_eval <<-CODE
      def self.#{role}
        find_by_name('#{role}')
      end
    CODE
  end
end
