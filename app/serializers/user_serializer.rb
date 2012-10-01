class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :vanity_url, :full_name, :signup_state,
             :followee_ids, :follower_ids, :username, :first_name,
             :last_name, :item_ids, :followee_count

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

=begin
  # TODO: add these as necessary. use Scope to decide which to include.
  Old JSON builder -- for reference
    json.url user.url
    json.country user.country
    json.description user.biography
    json.notify_new_follower user.notify_new_follower
    json.notify_relift user.notify_relift
    json.notify_missing user.notify_missing
    json.hometown user.hometown
    json.zipcode user.zipcode
    json.sex sex_to_string(user)
    json.avatar user.avatar(:small)
    json.avatar_url_thumb user.avatar(:thumb)
    json.hashtagbrand_ids ((user.hashtagbrands)?user.hashtagbrands.pluck(:id):'[]')
=end
end
