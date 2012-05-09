class Post < ActiveRecord::Base
  require 'status'
  
  belongs_to :user, :conditions => ["users.status = 1"]
  has_many :hashtags, :conditions => ["hashtags.status = 1"]
  has_many :items, :conditions => ["items.status = 1"]
  has_many :post_flags, :conditions => ["post_flags.status = 1"]

  has_attached_file :photo,
                    # resizing requires ImageMagick
                    :styles => {
                      #:thumb => "100x100#", TODO put this in user
                      :small => "383x383#"
                    },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:id/:filename"
  
  
  validates :name, :brand, :url, :retailer, :user_id, :presence => true
  
  # todo turn this on after unit tests are modified
  #validates_attachment_presence :photo
  
  define_index do
    indexes name, :sortable => true
  end
    
end
