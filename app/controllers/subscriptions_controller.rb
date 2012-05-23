class SubscriptionsController < ApplicationController
  
  # Fetch all current users subscriptions
  # * *Request*    :
  #   - GET /subscriptions
  # * *Args*    :
  #   - void
  def index
    authenticate_user!
    params[:id] = current_user.id
    return show
  end
  
  # Fetch all subscriptions for specified user
  # * *Request*    :
  #   - GET /subscriptions/users/:id
  # * *Args*    :
  #   - :id -> User id
  def show
    @user = User.where(:id => params[:id], :status => 1).first!
    if @user.private
      authenticate_user!
      if !current_user.subscribed_to(@user)
        return render_error(404,"Subscriptions not found")
      end
    end
    
    @subscriptions = Subscription.joins(:user) \
                                 .where("subscriptions.follower_id = ? AND subscriptions.status = 1",@user.id)
    render :show
  end
  
  # Subscribed to user
  # * *Request*    :
  #   - POST /subscriptions
  # * *Args*    :
  #   - :user_id -> User id
  def create
    authenticate_user!
    if Subscription.where("user_id = ? AND follower_id = ? AND status != 0",params[:user_id],current_user.id).first
      return render_error(406,"Subscription already exists")
    end
    @user = User.where(:id => params[:user_id], :status => 1).first!
    status = @user.private ? 2 : 1
    @subscription = Subscription.new(:user_id => params[:user_id], :follower_id => current_user.id, :status => status)
    
    if !@subscription.save
      return return_error_messages(@subscripion,"Error adding subscription")
    end
    
    render :partial => 'users/user', :locals => {:user => @subscription.user}, :status => 201
  end

  # Unsubscribe
  # * *Request*    :
  #   - DELETE /subscriptions/users/:id
  # * *Args*    :
  #   - :id -> User id  
  def destroy
    authenticate_user!
    @subscription = Subscription.where("user_id = ? AND follower_id = ? AND status != 0",params[:id],current_user.id).first!
    
    if !@subscription.deactivate
      return return_error_messages(@subscription,"Failed to delete subscription")
    end
    render :json => "Subscription successfully deleted", :status => 200
  end
  
end
