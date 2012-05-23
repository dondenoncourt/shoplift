# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  full_name              :string(110)     not null
#  username               :string(40)      not null
#  sex                    :boolean(1)
#  biography              :string(110)
#  url                    :text
#  hometown               :string(110)
#  birthdate              :date
#  private                :boolean(1)      default(FALSE), not null
#  status                 :integer(4)      default(1), not null
#  first_name             :string(255)
#  last_name              :string(255)
#  vanity_url             :string(255)
#  country                :string(255)
#  zipcode                :string(255)
#  missing                :string(255)
#  notify_new_follower    :boolean(1)
#  notify_relift          :boolean(1)
#  notify_missing         :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer(4)
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  require 'status'
  after_create :welcome
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :full_name, :username, :sex,
                  :biography, :url, :hometown, :birthdate, :private, :status,
                  :first_name, :last_name, :country, :vanity_url, :zipcode,
                  :notify_new_follower, :notify_relift, :notify_missing,
                  :avatar
  has_many :posts
  has_many :subscriptions
  has_many :followers, :class_name => "Subscription"

  has_attached_file :avatar,
                    :styles => {
                      :thumb => "80x80#",
                      :small => "200x200#"
                    },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:id/:filename"

  validates(:zipcode, presence: true)
  validates(:sex, presence: true)
  validates(:password_confirmation, presence: true, :unless => lambda {|u| u.password.nil? })

  def subscribed_to(user)
    if self.id != user.id && Subscription.where('user_id = ? AND follower_id = ? AND status = 1',user.id,self.id).blank?
      return false
     else
       return true 
    end
  end

  def welcome
    UserMailer.welcome(self).deliver
  end
end
