# == Schema Information
#
# Table name: roles_users
#
#  role_id :integer(4)
#  user_id :integer(4)
#

class RolesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
end
