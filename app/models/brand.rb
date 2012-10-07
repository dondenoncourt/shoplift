class Brand < ActiveRecord::Base
  validates :name, presence: true

  has_many :posts, :conditions => ['posts.status = 1']
  has_many :hashtags, :through => :posts
  has_many :hashtag_values, :through => :hashtags
  has_many :users, :through => :posts, :uniq => true
  has_one :hashtagbrand, :dependent => :delete

  after_create do |b|
    Hashtagbrand.create(:brand => b)
  end

  def items
    first = Post.joins(:items).where(:id => id).first
    first.items if first
  end

  def related_hashtagbrands(limit)
    hashtag_values.order('hashtags_count desc').limit(limit).map(&:hashtagbrand)
  end
end
