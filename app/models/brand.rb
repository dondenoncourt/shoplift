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
  has_many :posts
  has_many :users, :through => :posts, :uniq => true
  has_many :hashtagbrands, :dependent => :delete_all
  after_create {|b| Hashtagbrand.create(:brand => b)}
  def items
    first = Post.joins(:items).where(:id => id).first
    first.items if first
  end
end
