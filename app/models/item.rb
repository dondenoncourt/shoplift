class Item < ActiveRecord::Base
  belongs_to :post, :conditions => ["posts.status = 1"]
  has_one :user, :through => :post, :conditions => ["users.status = 1"]
  belongs_to :user, :conditions => ["users.status = 1"]
  has_many :hashtags, :through => :post, :conditions => ["hashtags.status = 1"]
  has_many :hashtag_values, :through => :hashtags
  has_many :hashtagbrands_hashtags, :through => :hashtag_values, :source => :hashtagbrand
  has_many :suggestions
  has_many :set_asides
  has_many :subscriptions, :foreign_key => :user_id, :primary_key => :user_id, :conditions => ["subscriptions.status = 1"]
  has_many :user_item_views, :through => :subscriptions, :foreign_key => 'subscriptions.follower_id', :primary_key => 'subscriptions.user_id'
  belongs_to :parent, :class_name => "Item", :foreign_key => "parent_id", :conditions => ["items.status = 1"]

  validates :user_id, :post_id, :presence => true
  validates :post_id, :uniqueness => {:scope => [:user_id]}

  scope :saved_by, lambda{ |user| joins(:set_asides).where('set_asides.user_id = ?', user.id) }

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
    return false if user == nil
    aside_by(user).present?
  end

  def aside_by(user)
    return false if user == nil
    set_asides.where(:user_id => user.id).first
  end
end
