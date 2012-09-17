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
#  facebook_token         :string(255)
#  twitter_token          :string(255)
#  twitter_secret         :string(255)
#

class User < ActiveRecord::Base
  require 'status'

  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable, :token_authenticatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :full_name, :username, :sex,
                  :biography, :url, :hometown, :birthdate, :private, :status,
                  :first_name, :last_name, :country, :vanity_url, :zipcode,
                  :notify_new_follower, :notify_relift, :notify_missing,
                  :avatar, :tos
  has_many :posts
  has_many :items
  has_many :subscriptions
  has_many :followers, :through => :subscriptions, :foreign_key => :follower_id, :class_name => 'User', :conditions => ["subscriptions.status = 1"]
  has_many :followees, :through => :subscriptions, :foreign_key => :user_id, :class_name => 'User', :conditions => ["subscriptions.status = 1"]
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

  validates :username, :full_name, presence: true
  validates :tos, :acceptance => true

  before_validation :set_username
  before_save :ensure_authentication_token
  after_create :send_welcome_email


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
  scope :without_user, lambda{ |user| where('users.id != ?', user.id) }

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

  def self.find_for_facebook_oauth(response, signed_in_resource=nil)
    facebook_token = response['credentials']['token']
    data = response.extra.raw_info
    if user = self.find_by_email(data.email)
      user.update_attribute('facebook_token',facebook_token)
      user
    else # Create a user with a stub password.
      hometown = data.location.name if data.location.present?
      sex = data.gender == 'male'
      self.create!(:full_name => data.name, :email => data.email, :password => Devise.friendly_token[0,20], :hometown => hometown, :sex => sex, :facebook_token => facebook_token )
    end
  end

  def facebook
    #oauth_token = 'AAADhGIBXiVcBAKqRZCqOlusCytFaZBysC4TZCEJdhGZCz10ePmXPYxDHtMnPGs0I253Fk17BHRqzt6s1axWhlaYsQqbkjBAN4D5ssRNr3QZDZD'
    @facebook ||= Koala::Facebook::API.new(facebook_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil # or consider a custom null object
  end

  def friends_count
    facebook { |fb| fb.get_connection("me", "friends").size }
  end

  def self.find_for_twitter_oauth(fromTwitter, params)
    if user = User.find_by_email(params[:email])
      user.twitter_token = fromTwitter['credentials']['token']
      user.twitter_secret = fromTwitter['credentials']['secret']
      user.save
      user
    else 
      #TODO this should be some form of an error
    end
  end
  
  def twitter(tweet_text, oauth_token, oauth_token_secret)
    #TODO These twitter hard coded values are also stored in config/devise.rb and should be placed in a single global constant
    consumer = OAuth::Consumer.new("Mka8NshDT9rwsHZzU53lg", "m7nv7FfWMSH2h9pEr1RMJHUyaXZaAT4qfVTBa1mouI",
      { :site => "http://api.twitter.com"}
    )
    # now create the access token object from passed values
    token_hash = { :oauth_token => oauth_token,
                   :oauth_token_secret => oauth_token_secret
    }     
    acsTkn = OAuth::AccessToken.from_hash(consumer, token_hash)
    resp = acsTkn.request(:post, "http://api.twitter.com/1/statuses/update.json", :status => tweet_text)
  rescue Exception => e
    puts e.message  
    puts e.backtrace.inspect  
  end  

  def self.share_lift(user_id, item_url)    
    user = User.find(user_id) 
    if user.facebook_token
      # use this when the lift is commented
      #user.facebook.put_connections("me", "notes", :subject => "lifted", :message => item_url.gsub(/http:\/\/.*items/,'items'))
      begin
        # this works but comment until we go live
        user.facebook.put_connections("me", "the_shoplift:lift", object: item_url)
      rescue Exception => e
        puts e.message  
        puts e.backtrace.inspect  
      end
    end
    
    if !user.twitter_token.blank? && !user.twitter_secret.blank?       
      tweetText = user.full_name + ' shoplifted ' + item_url
      user.twitter(tweetText, user.twitter_token, user.twitter_secret)
    end    
  rescue Exception => e
    puts e.message  
    puts e.backtrace.inspect  
  end

  def set_username
    self.username = self.email
  end

  def subscribed_to(user)
    self.id != user.id && Subscription.where(:user_id => user.id, :follower_id => self.id, :status => 1).first.present?
  end
  alias following? subscribed_to

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end

  def followees
    User.joins(:subscriptions).where('subscriptions.follower_id = ? AND subscriptions.status = 1', self.id)
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

  def hashtagbrands
    Hashtagbrand.where({:brand_id => posts.pluck('brand_id').compact.uniq} ||
                       {:hashtag_value_id => hashtag_values.pluck('hashtag_value_id').compact.uniq})
  end
  
end
