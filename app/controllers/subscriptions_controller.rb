class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  respond_to :json

  def index
    params[:id] = current_user.id
    return show
  end

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

  def create
    user = User.find(params[:user_id])

    status = user.private ? Status::SUSPENDED: Status::ACTIVATED

    subscription = Subscription.where(:user_id => user.id, :follower_id => current_user.id).first_or_create
    subscription.update_attribute(:status, status)

    binding.pry
    if subscription.persisted?
      render json: { status: 200 }
    else
      return_error_messages(subscription, "Error adding subscription")
    end
  end

  def destroy
    subscription = Subscription.where(:user_id => params[:id], :follower_id => current_user.id).first

    # TODO: deactivate rather then delete
    if subscription.destroy
      render :json => { status: 200 }
    else
      return_error_messages(subscription, "Failed to delete subscription")
    end
  end

end
