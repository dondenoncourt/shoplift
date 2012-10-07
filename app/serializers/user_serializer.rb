class UserSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :email, :vanity_url, :full_name, :signup_state,
             :username, :first_name, :last_name,:item_ids, :followee_count

  has_many :followers,     :include => false
  has_many :followees,     :include => false
  has_many :items,         :include => false
  has_many :hashtagbrands, :include => false

  def followee_count
    object.followees.count
  end

  def include_followee_count?
    is_current_user?
  end

  def is_current_user?
    scope == object
  end

  def item_ids
    object.items.order('items.created_at DESC').pluck('items.id')
  end
end
