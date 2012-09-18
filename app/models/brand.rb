# == Schema Information
#
# Table name: brands
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  reviewed    :boolean(1)      default(FALSE), not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  posts_count :integer(4)      default(0)
#
#
class Brand < ActiveRecord::Base
  validates :name, presence: true
  has_many :posts, :conditions => ['posts.status = 1']
  has_many :hashtags, :through => :posts
  has_many :hashtag_values, :through => :hashtags
  has_many :users, :through => :posts, :uniq => true
  has_one :hashtagbrand, :dependent => :delete
  after_create {|b| Hashtagbrand.create(:brand => b)}
  def items
    first = Post.joins(:items).where(:id => id).first
    first.items if first
  end

  def related_hashtagbrands(limit)
    hashtag_values.order('hashtags_count desc').limit(limit).map(&:hashtagbrand)
  end
end
