class FollowersController < ApplicationController
  
  # Fetch all current users followers
  # * *Request*    :
  #   - GET /followers
  # * *Args*    :
  #   - void
  def index
    authenticate_user!
    params[:id] = current_user.id
    return show
  end
  
  # Fetch all followers of specified user
  # * *Request*    :
  #   - GET /followers/users/:id
  # * *Args*    :
  #   - :id -> User id
  def show
    @user = User.where(:id => params[:id], :status => 1).first!
     if @user.private
      authenticate_user!
      if !current_user.subscribed_to(@user)
        return render_error(404,"User not found")
      end
    end

    @subscriptions = Subscription.joins(:follower,:user).where("subscriptions.status = 1 AND subscriptions.user_id = ?",@user.id)
    render :show
  end
  
  # Fetch all pending requests to be followed
  # * *Request*    :
  #   - GET /followers/pending
  # * *Args*    :
  #   - void
  def show_pending
    authenticate_user!
    @subscriptions = Subscription.joins(:follower,:user).where("subscriptions.status = 2 AND subscriptions.user_id = ?",current_user.id)
    render :show
  end
  
  # Approve followers request
  # * *Request*    :
  #   - PUT /followers/users/:id
  # * *Args*    :
  #   - :id -> User id
  def approve
    authenticate_user!
    @subscription = Subscription.joins(:follower,:user).readonly(false) \
    .where("subscriptions.status = 2 AND subscriptions.user_id = ? AND subscriptions.follower_id = ?", current_user.id, params[:user_id]).first!

    if !@subscription.activate
      render_error(500, "Failed to activate subscription")
    else
      render :partial => 'users/user', :locals => {:user => @subscription.follower}
    end
  end
  
  # Remove follower
  # * *Request*    :
  #   - DELETE /followers/users/:id
  # * *Args*    :
  #   - :id -> User id
  def destroy
    authenticate_user!
    @subscription = Subscription.where("user_id = ? AND follower_id = ? AND status != 0",current_user.id,params[:id]).first!
    
    if !@subscription.deactivate
      render_error(500, "Failed to delete follower")
    else
      render :json => "Follower successfully deleted", :status => 200
    end  
  end
  
end
