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
#  authentication_token   :string(255)
#  count_of_followers     :integer(4)      default(0)
#  latitude               :float
#  longitude              :float
#  count_of_posts         :integer(4)      default(0)
#  count_of_hashtags      :integer(4)      default(0)
#

class User < ActiveRecord::Base
  require 'status'
  after_create :welcome

  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable, :token_authenticatable#, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :full_name, :username, :sex,
                  :biography, :url, :hometown, :birthdate, :private, :status,
                  :first_name, :last_name, :country, :vanity_url, :zipcode,
                  :notify_new_follower, :notify_relift, :notify_missing,
                  :avatar, :tos
  has_many :posts
  has_many :subscriptions
  has_many :followers, :class_name => "Subscription"
  has_many :hashtags
  has_many :hashtag_values, :through => :hashtags
  has_and_belongs_to_many :roles

  has_attached_file :avatar,
                    :styles => {
                      :tiny => "20x20#",
                      :thumb => "70x70#",
                      :small => "200x200>"
                    },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:id/:filename",
                    :default_url => "/assets/avatars/:style/missing.png"

  validates :zipcode, :sex, :username, presence: true
  validates(:password_confirmation, presence: true, :unless => lambda {|u| u.password.nil? })
  validates :tos, :acceptance => true

  before_validation :set_username
  before_save :ensure_authentication_token

  default_scope where('users.status = 1')
  #
  ### Scopes for followee suggestions. They could also be methods if needed but must return an AR relation
  #
  scope :popular, order('count_of_followers DESC')
  scope :recommended, order('count_of_posts DESC, count_of_hashtags DESC')
  scope :staff_picks, order('count_of_followers DESC, count_of_posts DESC, count_of_hashtags DESC')
  scope :trending, where("exists (select * from items where items.user_id = users.id and items.created_at > ? ) ", Date.today - 7).order('count_of_followers DESC')
  scope :local_favorites, lambda{ |user| User.near([user.latitude, user.longitude], 20) }
  # scope :friends

  def self.by_option(option, args=nil)
    if option.present? && self.respond_to?(option)
      self.send(option, args)
    else
      scoped
    end
  end

  def self.by_category(category)
    if category.present? && Category.where(:param => category).first.present?
      scoped # TODO
    else
      scoped
    end
  end

  def set_username
    self.username = self.email
  end

  def subscribed_to(user)
    self.id != user.id && Subscription.where(:user_id => user.id, :follower_id => self.id, :status => 1).first.present?
  end
  alias following? subscribed_to

  def welcome
    UserMailer.welcome(self).deliver
  end

  def followees
    Subscription.where(follower_id: self.id)
  end

  def items
    Item.joins(:post => :user)
        .where("items.status = 1 AND items.user_id = ?", self.id)
        .order("items.created_at DESC")
        .group("items.id")
  end

  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

  def is_following_enough?
    followees.count > 0
  end

  def has_role?(role)
    self.roles.send(role).present?
  end
  alias role? has_role?

  def full_street_address
    %{hometown zipcode country}
  end

  #geocoded_by :full_street_address   # can also be an IP address
  def address
    [hometown, zipcode, country].compact.join(', ')
  end
  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  
end
