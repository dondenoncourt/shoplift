class User < ActiveRecord::Base
  default_scope { where(status: Status::ACTIVATED ) }

  geocoded_by :address   # can also be an IP address

  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :trackable, :validatable, :token_authenticatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :full_name, :username, :sex,
                  :biography, :url, :hometown, :month, :day, :year, :private, :status,
                  :first_name, :last_name, :country, :vanity_url, :zipcode,
                  :notify_new_follower, :notify_relift, :notify_missing,
                  :tos, :signup_state, :original_url, :large_url, :thumb_url

  has_many :posts
  has_many :items
  has_many :subscriptions
  # has_many :followers, :source      => :user,
  #                      :class_name  => 'User',
  #                      :through     => :subscriptions,
  #                      :primary_key => :follower_id,
  #                      :conditions  => ["subscriptions.status = #{Status::ACTIVATED}"]


  def followers
    query = User.
      joins(:subscriptions).
      where('subscriptions.user_id' => id).
      select('subscriptions.follower_id').to_sql

    ids = User.connection.execute(query).values.flatten.map(&:to_i)

    User.where(id: ids)
  end

  def follower_ids
    followers.pluck(:id)
  end

  def followees
    query = User.
      joins(:subscriptions).
      where('subscriptions.follower_id' => id).
      select('subscriptions.user_id').to_sql

    ids = User.connection.execute(query).values.flatten.map(&:to_i)

    User.where(id: ids)
  end

  def followee_ids
    followees.pluck(:id)
  end

  def follows?(user_id)
    followees.find(user_id).present?
  rescue ActiveRecord::RecordNotFound
    false
  end

  def followed?(user_id)
    User.find(user_id).first.followers.find(id).first.present?
  rescue ActiveRecord::RecordNotFound
    false
  end

  #has_many :followees, :source      => :follower,
  #                     :class_name  => 'User',
  #                     :through     => :subscriptions,
  #                     :foreign_key => :user_id,
  #                     :conditions  => ["subscriptions.status = 1"]

  has_many :hashtags
  has_many :hashtag_values, :through => :hashtags
  has_and_belongs_to_many :roles


  before_validation :set_username
  after_validation :geocode
  before_save :ensure_authentication_token #, :deserialize_date
  after_create :send_welcome_email

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

  # To maintain the different validations that kick in depending
  # on how much information the user has typed in, we'll use a state machine.
  # The states are:
  # 1) User created / email entered (:email)
  # 2) Name entered (:name)
  # 3) member / password and vanity url entered (:member)
  # state_machine :signup_state, :initial => :email do
  #   state :name do
  #     validates :tos, :acceptance => true
  #   end
  # 
  #   state :member do
  #     validates :tos, :acceptance => true
  #   end
  # 
  #   state all do
  #     # All states require email and username to have been set.
  #     validates :email, :username, presence: true
  #   end
  # 
  #   state all - [:email] do
  #     # All states after entering e-mail require
  #     # the name to have been entered
  #     validates :full_name, presence: true
  #   end
  # 
  #   state :member do
  #     #validates :vanity_url, presence: true
  #     validates :tos, :acceptance => true
  #   end
  # end

  def followers_ids
    followers.pluck('users.id')
  end

  def follwees_ids
    followees.pluck('users.id')
  end

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
  
  def deserialize_date
    birthdate = Date.new(read_attribute(:year), read_attribute(:month), read_attribute(:day))
  end
  
  def year=(year)
    write_attribute(:birthdate, Date.new(1990, 3, 28))
  end
  def month=(month)
    #read_attribute(:birthdate).month
  end
  def day=(day)
    #read_attribute(:birthdate).day
  end
  def year
    read_attribute(:birthdate).year
  end
  def month
    read_attribute(:birthdate).month
  end
  def day
    read_attribute(:birthdate).day
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

  def address
    [hometown, zipcode, country].compact.join(', ')
  end

  def hashtagbrands
    Hashtagbrand.where({:brand_id => posts.pluck('brand_id').compact.uniq} ||
                       {:hashtag_value_id => hashtag_values.pluck('hashtag_value_id').compact.uniq})
  end
end
