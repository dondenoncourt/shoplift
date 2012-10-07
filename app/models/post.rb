class Post < ActiveRecord::Base
  belongs_to :user, :conditions => ["users.status = 1"], :counter_cache => :count_of_posts
  belongs_to :brand, :counter_cache => true
  has_many :hashtags, :conditions => ["hashtags.status = 1"]
  has_many :items, :conditions => ["items.status = 1"]
  has_many :post_flags, :conditions => ["post_flags.status = 1"]

  has_attached_file :photo,
                    :styles => {
                      :small => "383x383#"
                    },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:id/:filename"

  validates :url, :retailer, :user_id, :presence => true

  # todo turn this on after unit tests are modified
  #validates_attachment_presence :photo

  define_index do
    indexes name, :sortable => true
  end

end
