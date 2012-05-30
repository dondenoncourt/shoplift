# == Schema Information
#
# Table name: items
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)      not null
#  post_id    :integer(4)      not null
#  parent_id  :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  status     :integer(4)      default(1), not null
#  views      :integer(4)      default(0), not null
#  visits     :integer(4)      default(0), not null
#  relifts    :integer(4)      default(0), not null
#  comment    :string(100)
#

class Item < ActiveRecord::Base
  require 'status'

  belongs_to :post, :conditions => ["posts.status = 1"]
  has_one :user, :through => :post, :conditions => ["users.status = 1"]
  belongs_to :user, :conditions => ["users.status = 1"]
  has_many :hashtags, :through => :post, :conditions => ["hashtags.status = 1"]
  has_many :hashtag_values, :through => :hashtags
  has_many :suggestions
  has_many :set_asides
  belongs_to :parent, :class_name => "Item", :foreign_key => "parent_id", :conditions => ["items.status = 1"]

  validates :user_id, :post_id, :presence => true
  validates :post_id, :uniqueness => {:scope => [:user_id]}

  scope :saved_by, lambda{ |user| joins(:set_asides).where(:user_id => user.id) }

  def self.between(params)
    return scoped unless params[:above].present? && params[:below].present?
    where("#{table_name}.id BETWEEN #{params[:above]} AND #{params[:below]}")
  end

  def retailer
    post.retailer
  end

  def name
    post.name
  end

  def price
    post.price
  end

  def photo
    post.photo
  end

  def items
    post.items
  end

  def <=> other
    self.created_at <=> other.created_at
  end

  def saved_by?(user)
    aside_by(user).present?
  end

  def aside_by(user)
    set_asides.where(:user_id => user.id).first
  end

end
