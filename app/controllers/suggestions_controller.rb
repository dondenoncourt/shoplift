class SuggestionsController < ApplicationController
  before_filter :authenticate_user!

  # Fetch suggestions
  # * *Request*    :
  #   - GET /suggestions
  # * *Args*    :
  #   - :limit -> Number of suggestions to be returned
  def index
    limit = params[:limit].blank? ? 20 : 1
    @suggestions = Item.joins(:post,:user) \
                       .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND post_users.status = 1") \
                       .joins("LEFT OUTER JOIN subscriptions ON items.user_id = subscriptions.user_id AND subscriptions.status = 1") \
                       .where("posts.user_id != ? AND items.user_id != ? AND (subscriptions.follower_id != ? OR subscriptions.id IS NULL)",current_user.id,current_user.id,current_user.id) \
                       .order("RANDOM()") \
                       .group("items.id") \
                       .limit(limit)
  end
end
