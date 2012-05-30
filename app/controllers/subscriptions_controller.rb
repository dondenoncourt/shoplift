class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  # Fetch all current users subscriptions
  # * *Request*    :
  #   - GET /subscriptions
  # * *Args*    :
  #   - void
  def index
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
    user = User.find(params[:user_id])
    status = user.private ? 2 : 1
    subscription = Subscription.where(:user_id => user.id, :follower_id => current_user.id).first_or_create
    subscription.update_attribute(:status, status)

    if subscription.persisted?
      # send email to user
      render :partial => 'users/user', :locals => { :user => user }, :status => 201
    else
      return_error_messages(subscription, "Error adding subscription")
    end
  end

  # Unsubscribe
  # * *Request*    :
  #   - DELETE /subscriptions/users/:id
  # * *Args*    :
  #   - :id -> User id
  def destroy
    subscription = Subscription.where(:user_id => params[:id], :follower_id => current_user.id).first

    if subscription.deactivate
      render :json => "Subscription successfully deleted".to_json, :status => 200
    else
      return_error_messages(subscription, "Failed to delete subscription")
    end
  end

end
