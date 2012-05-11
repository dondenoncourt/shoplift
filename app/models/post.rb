# == Schema Information
#
# Table name: posts
#
#  id                 :integer(4)      not null, primary key
#  name               :string(110)     not null
#  description        :text
#  brand              :string(255)     not null
#  retailer           :string(255)     not null
#  url                :string(2083)    not null
#  price              :decimal(10, 2)
#  hashtags_allowed   :boolean(1)      default(TRUE), not null
#  comment            :string(100)
#  user_id            :integer(4)      not null
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  status             :integer(4)      default(1), not null
#  views              :integer(4)      default(0), not null
#  visits             :integer(4)      default(0), not null
#  relifts            :integer(4)      default(0), not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer(4)
#  photo_updated_at   :datetime
#

class Post < ActiveRecord::Base
  require 'status'
  
  belongs_to :user, :conditions => ["users.status = 1"]
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
  
  
  validates :name, :brand, :url, :retailer, :user_id, :presence => true
  
  # todo turn this on after unit tests are modified
  #validates_attachment_presence :photo
  
  define_index do
    indexes name, :sortable => true
  end
    
end
