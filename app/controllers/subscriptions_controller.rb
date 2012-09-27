class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  # =begin apidoc
  # url:: /subscriptions
  # method:: GET
  # access:: FREE
  # return:: Fetch all current users subscriptions
  # output:: json
  # [{"subscriptions":[{"extract":{"id":2,"email":"patrick@elsewhere.net","username":"patrick@elsewhere.net","full_name":"Patrick Camacho","first_name":"Patrick","last_name":"Camacho","url":"http://38media.net","vanity_url":"http://38media.net","country":"United States","biography":"I like dogs","notify_new_follower":true,"notify_relift":false,"notify_missing":"daily","hometown":"Waltham, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/2/headless.jpg?1337213827","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/2/headless.jpg?1337213827","followee_count":3},{"extract":{"id":6,"email":"mike@zstudiolabs.com","username":"mike@zstudiolabs.com","full_name":"Mike","first_name":null,"last_name":null,"url":"http://www.ZStudioLabs.com","vanity_url":null,"country":"United States","biography":"Professional scuba diver, amateur rock climber.","notify_new_follower":true,"notify_relift":true,"notify_missing":"daily","hometown":null,"zipcode":"83703","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/6/Mike.jpg?1338540852","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/6/Mike.jpg?1338540852","followee_count":3},{"extract":{"id":7,"email":"brandon@theshoplift.com","username":"brandon@theshoplift.com","full_name":"Brandon Fail","first_name":null,"last_name":null,"url":"www.theshoplift.com","vanity_url":null,"country":"United States","biography":"Here's my blurb everybody!  ","notify_new_follower":true,"notify_relift":true,"notify_missing":"daily","hometown":null,"zipcode":"10014","sex":true},"sex":"Male","avatar_url_small":"/assets/avatars/small/missing.png","avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":3}]}]
  # ::output-end::
  # Fetch all current users subscriptions
  # <br/><br/>Notes:<pre>curl -X GET -u mark@elsewhere.net:vo2max localhost:3000/subscriptions/users/1</pre>
  # =end
  def index
    params[:id] = current_user.id
    return show
  end

  # =begin apidoc
  # url:: /subscriptions/users/:id
  # method:: GET
  # access:: FREE
  # return:: list of users that the passed id is following
  # output:: json
  # [{"subscriptions":[{"extract":{"id":2,"email":"patrick@elsewhere.net","username":"patrick@elsewhere.net","full_name":"Patrick Camacho","first_name":"Patrick","last_name":"Camacho","url":"http://38media.net","vanity_url":"http://38media.net","country":"United States","biography":"I like dogs","notify_new_follower":true,"notify_relift":false,"notify_missing":"daily","hometown":"Waltham, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/2/headless.jpg?1337213827","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/2/headless.jpg?1337213827","followee_count":1}]}]
  # ::output-end::
  # Get a list of all the users that passed id's user is following.
  # <br/><br/>Notes:<pre>curl -X GET -u mark@elsewhere.net:vo2max localhost:3000/subscriptions/users/1</pre>
  # =end
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

  # =begin apidoc
  # url:: /subscriptions/:id
  # method:: POST
  # access:: FREE
  # return:: users that user is following
  # param:: user_id:int - the id of the user to follow
  # output:: json
  # {"extract":{"id":2,"email":"patrick@elsewhere.net","username":"patrick@elsewhere.net","full_name":"Patrick Camacho","first_name":"Patrick","last_name":"Camacho","url":"http://38media.net","vanity_url":"http://38media.net","country":"United States","biography":"I like dogs","notify_new_follower":true,"notify_relift":false,"notify_missing":"daily","hometown":"Waltham, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/2/headless.jpg?1337213827","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/2/headless.jpg?1337213827","followee_count":9}
  # ::output-end::
  # Start following (a.k.a. subscribe to) a user
  # <br/><br/>Notes:<pre>curl -X POST -u mark@elsewhere.net:vo2max localhost:3000/subscriptions.json?user_id=2</pre>
  # =end
  def create
    user = User.find(params[:user_id])
    status = user.private ? 2 : 1
    subscription = Subscription.where(:user_id => user.id, :follower_id => current_user.id).first_or_create
    subscription.update_attribute(:status, status)

    if subscription.persisted?
      render :partial => 'users/user', :locals => { :user => user }, :status => 201
    else
      return_error_messages(subscription, "Error adding subscription")
    end
  end

  # =begin apidoc
  # url:: /subscriptions/:id
  # method:: DELETE
  # access:: FREE
  # return:: followee count
  # param:: user_id:int - the id of the user to stop following
  # output:: json
  # [  {"followee_count":8}  ]
  # ::output-end::
  # Stop following (a.k.a. unsubscribe to) a user
  # <br/><br/>Notes:<pre>curl -X DELETE -u mark@elsewhere.net:vo2max localhost:3000/subscriptions/users/2</pre>
  # =end
  def destroy
    subscription = Subscription.where(:user_id => params[:id], :follower_id => current_user.id).first

    if subscription.deactivate
      render :json => { :followee_count => current_user.followees.count }, :status => 200
    else
      return_error_messages(subscription, "Failed to delete subscription")
    end
  end

end
