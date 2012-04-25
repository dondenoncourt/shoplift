class User < ActiveRecord::Base
  require 'status'
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :password, :full_name, :username, :sex, 
                  :biography, :url, :hometown, :birthdate, :private, :status
  has_many :posts
  has_many :subscriptions
  has_many :followers, :class_name => "Subscription"
  def subscribed_to(user)
    if self.id != user.id && Subscription.where('user_id = ? AND follower_id = ? AND status = 1',user.id,self.id).blank?
      return false
     else
       return true 
    end
  end
end
