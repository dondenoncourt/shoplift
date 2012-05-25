class TimelinesController < ApplicationController

  # Fetch up to 50 items of current user and that of his/her subscriptions
  # * *Request*    :
  #   - GET /timelines
  # * *Args*    :
  #   - :above -> Highest id to obtain items between
  #   - :below -> Lowest id to obtain items between
  #   - :limit -> Number of items to return
  def index
    authenticate_user!
    #if !params[:limit].blank? && params[:limit] >= 50
      #return render_error(406,"Limit must be less than or equal to 50")
    #end

    @items = Item.joins(:post,:user,"INNER JOIN subscriptions ON subscriptions.user_id = items.user_id AND subscriptions.status = 1")
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1")
                 .where("items.status = 1 AND (subscriptions.follower_id = ? )",current_user.id)
                 .between(params)
                 .order("items.created_at DESC")
                 .group("items.id")
                 .limit(limit)
  end

  # Fetch up to 50 items of a specified user
  # * *Request*    :
  #   - GET /timelines/users/:id
  # * *Args*    :
  #   - :id -> User id
  #   - :above -> Highest id to obtain items between
  #   - :below -> Lowest id to obtain items between
  #   - :limit -> Number of items to return
  def show_user
    @user = User.find(params[:id])

    if @user.private
      authenticate_user!
      if !current_user.subscribed_to(@user)
        return render_error(404,"User not found")
      end
    end

    if !params[:limit].blank? && params[:limit] >= 50
      return render_error(406,"Limit must be less than or equal to 50")
    end

    @items = Item.joins(:post,:user) \
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                 .where("items.status = 1 AND items.user_id = ?",@user.id) \
                 .between(params)
                 .order("items.created_at DESC") \
                 .group("items.id") \
                 .limit(limit)
     render :index
  end

  # Fetch up to 50 of the most recent items posted
  # * *Request*    :
  #   - GET /timelines/recent
  # * *Args*    :
  #   - :above -> Highest id to obtain items between
  #   - :below -> Lowest id to obtain items between
  #   - :limit -> Number of items to return
  def show_recent
    if !params[:limit].blank? && params[:limit] >= 50
      return render_error(406,"Limit must be less than or equal to 50")
    end

    @items = Item.joins(:post,:user) \
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                 .where("items.status = 1 AND users.private != 1") \
                 .between(params)
                 .order("items.created_at DESC") \
                 .group("items.id") \
                 .limit(limit)
     render :index

  end

  # Fetch up to 50 items that match hashtag name
  # * *Request*    :
  #   - GET /timelines/hashtags/:name
  # * *Args*    :
  #   - :name -> Hashtag value
  #   - :limit -> Number of items to return
  def show_hashtags
    limit = params[:limit].blank? ? 20 : params[:limit]
    @items = Item.joins(:post,:user,:hashtags,:hashtag_values) \
                  .where("items.status = 1 AND hashtag_values.value = ?",params[:name]) \
                  .order("items.created_at DESC") \
                  .group("items.id") \
                  .limit(limit)
    render :index
  end

  private

  def limit
    params[:limit] || 20
  end

end
