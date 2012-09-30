class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    can :read, [Item, User, Hashtag, Category] #anyone can read an item, user, or hashtag
    can :create, User

    if user.role? :admin
      can :manage, :all
    elsif user.role? :user
      can :update, Item do |item|
        item.try(:user) == user
      end
      can :update, Post do |post|
        post.try(:user) == user
      end
      can :create, [Post, Item, Hashtag, ItemFlag, HashtagFlag]
      can :update, Hashtag do |hashtag|
        hashtag.try(:user) == user || hashtag.post.try(:user) == user
      end
    end
  end
end
