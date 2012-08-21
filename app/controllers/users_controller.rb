class UsersController < ApplicationController
  before_filter :authenticate_user!

  # =begin apidoc
  # url:: /shoplifters.json
  # method:: GET
  # access:: FREE
  # return:: list of users
  # param:: page:int - the page, default is 1 (optional)
  # param:: per_page:int - max items per page, default is 2 (optional)
  # output:: json
  # [{"avatar_content_type":"image/jpeg","avatar_file_name":"bella_4.5_mths.jpg","avatar_file_size":151209,"avatar_updated_at":"2012-05-16T19:05:57-05:00","biography":"I like computers","birthdate":"1987-05-24","count_of_followers":1,"count_of_hashtags":0,"count_of_posts":0,"country":null,"created_at":"2011-12-19T23:04:53-06:00","email":"mark@38media.net","first_name":"Mark","full_name":"Mark A. Roseboom","hometown":"Boston, MA","id":1,"last_name":"Roseboom","latitude":null,"longitude":null,"missing":null,"notify_missing":null,"notify_new_follower":null,"notify_relift":null,"private":false,"sex":true,"status":1,"updated_at":"2012-02-09T10:50:43-06:00","url":"http://38media.net","username":"mroseboom","vanity_url":null,"zipcode":null}]
  # ::output-end::
  # Get a list of all users in the system with pagination.  Defaults to 2 per page
  # <br/><br/>Notes:<pre>curl -X GET --user aaronbartell@gmail.com:poopydiaper localhost:3000/shoplifters.json</pre>
  # =end
  def index
    users
    if request.xhr?
      render partial: users
    else
      respond_to do |format|
        format.html
        format.json { render json: users }
      end
    end
  end

  # =begin apidoc
  # url:: /users/:id.json
  # method:: GET
  # access:: FREE
  # return:: user data
  # param:: id:int - the id of the user
  # output:: json
  # {"extract":{"id":18,"email":"bozo@test.com","username":"bozo@test.com","full_name":"Bozo Clown","first_name":null,"last_name":null,"vanity_url":null,"country":"United States","biography":null,"notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":null,"zipcode":"","sex":null},"sex":"Female","avatar_url_small":"/assets/avatars/small/missing.png","avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":5}
  # ::output-end::
  # Get the user's information
  # <br/><br/>Notes:<pre>curl -X GET --user aaronbartell@gmail.com:poopydiaper localhost:3000/users/1.json</pre>
  # =end
  def show
    if request.xhr?
      render partial: items
    else
      items
      if user.private? && !current_user.subscribed_to(user)
        render_error(404,"Item not found")
      else
        respond_to do |format|
          format.html
          format.json { render user }
        end
      end
    end
  end

  # =begin apidoc
  # url:: /users/validate_username.json
  # method:: POST
  # access:: FREE
  # return:: user data
  # param:: username:string - name of the user
  # output:: json
  # {"extract":{"id":11,"email":"aaronbartell@gmail.com","username":"aaronbartell@gmail.com","full_name":"aaron","first_name":null,"last_name":null,"vanity_url":null,"country":"United States","biography":null,"notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":null,"zipcode":"56001","sex":true},"sex":"Male","avatar_url_small":"/assets/avatars/small/missing.png","avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":2 }
  # ::output-end::
  # Get the user's information by way of username
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:poopydiaper -d "username=aaronbartell@gmail.com" http://ec2-23-23-244-185.compute-1.amazonaws.com/users/validate_username.json</pre>
  # =end
  def validate_username
    if @user = User.find_by_username(params[:username].downcase)
      render :partial => "user", :locals => {:user => @user}
    else
      render_error(404,"User not found")
    end
  end

  # =begin apidoc
  # url:: /users.json
  # method:: POST
  # access:: FREE
  # return:: array of user data
  # param:: HTML form submission. See curl example.
  # output:: json
  # { "avatar_content_type" : null,"avatar_file_name" : null,"avatar_file_size" : null,"avatar_updated_at" : null,"biography" : null,"birthdate" : null,"count_of_followers" : 0,"count_of_hashtags" : 0,"count_of_posts" : 0,"country" : null,"created_at" : "2012-06-19T07:57:46-05:00","email" : "aaronbartell@gmail.com3","first_name" : null,"full_name" : "Aaron Bartell3","hometown" : null, "id" : 13, "last_name" : null,"latitude" : null,"longitude" : null, "missing" : null,"notify_missing" : null,"notify_new_follower" : null,"notify_relift" : null, "private" : false, "sex" : null, "status" : 1,"updated_at" : "2012-06-19T07:57:46-05:00","url" : null,"username" : "aaronbartell@gmail.com3","vanity_url" : null,"zipcode" : null}
  # ::output-end::
  # Create a new user
  # <br/><br/>Notes:<pre>curl -d "user[full_name]=Aaron Bartell3" -d "user[email]=aaronbartell@gmail.com3" -d "user[password]=poopydiaper" localhost:3000/users.json</pre>
  # =end
  def create
    @user = User.new(params[:user])
    if @user.save
      render :partial => 'user', :locals => {:user => @user}, :status => 201
    else
      return_error_messages(@user,"Failed to create user")
    end
  end

  # =begin apidoc
  # url:: /users/:id/edit.json
  # method:: POST
  # access:: FREE
  # return:: array of user data
  # param:: id - user id on URL
  # param:: HTML form in POST content. See curl example.
  # output:: json
  # { "avatar_url_small" : "/assets/avatars/small/missing.png","avatar_url_thumb" : "/assets/avatars/thumb/missing.png","extract" : { "biography" : null,"country" : null,"email" : "aaronbartell@gmail.com5","first_name" : null,"full_name" : "Aaron Bartell5","hometown" : null,"id" : 13,"last_name" : null,"notify_missing" : null,"notify_new_follower" : null,"notify_relift" : null,"sex" : null,"username" : "aaronbartell@gmail.com5","vanity_url" : null,"zipcode" : null},"followee_count" : 2,"sex" : "Female"}
  # ::output-end::
  # Edit (update) user
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:poopydiaper -d "user[full_name]=Aaron Bartell5" -d "user[email]=aaronbartell@gmail.com5" localhost:3000/users/13/edit.json</pre>
  # =end
  def update
    ## Check if user is updating themselve or another (must be admin) ##
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      render :partial => 'user', :locals => {:user => @user}
    else
      return_error_messages(@user,"Failed to update user")
    end
  end

  # =begin apidoc
  # url:: /users/:id/delete.json
  # curl:: curl -x POST something
  # method:: POST
  # access:: FREE
  # return:: array of user data
  # param:: id - user id to delete
  # output:: json
  # { "avatar_content_type" : null,"avatar_file_name" : null,"avatar_file_size" : null,"avatar_updated_at" : null,"biography" : null,"birthdate" : null,"count_of_followers" : 0,"count_of_hashtags" : 0,"count_of_posts" : 0,"country" : null,"created_at" : "2012-06-19T07:57:46-05:00","email" : "aaronbartell@gmail.com5","first_name" : null,"full_name" : "Aaron Bartell5","hometown" : null,"id" : 13,"last_name" : null,"latitude" : null,"longitude" : null,"missing" : null,"notify_missing" : null,"notify_new_follower" : null,"notify_relift" : null,"private" : false,"sex" : null,"status" : 0,"updated_at" : "2012-06-19T08:36:22-05:00","url" : null,"username" : "aaronbartell@gmail.com5","vanity_url" : null,"zipcode" : null}
  # ::output-end::
  # Update user
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:poopydiaper localhost:3000/users/13/delete.json</pre>
  # =end
  def destroy
    ## Check if user is updating themselve or another (must be admin) ##
    @user = User.find(params[:id])
    @user.deactivate
    if @user.status == 0
      return render :json => @user, :status => 200
    else
      return_error_messages(@user,"Failed to delete user")
    end
  end

  # =begin apidoc
  # url:: /users/avatar.json
  # method:: POST
  # access:: FREE
  # return:: user data
  # param:: username:string (optional) - pass only if you want an avatar for a user that is different from the authenticated user.
  # param:: style:string (optional) - Values tiny|thumb|small. Default is tiny. 
  # output:: URL
  # http://s3.amazonaws.com/shoplift_dev/thumb/2/headless.jpg?1337213827
  # ::output-end::
  # Get the user's avatar URL
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:thinkpad -d "username=aaronbartell@gmail.com" -d "style=thumb" localhost:3000/users/avatar.json</pre>
  # =end
  def avatar
    @usrNam
    if params.has_key?(:username)
      @usrNam = params[:username]
    else
      @usrNam = current_user.username 
    end 
    if @user = User.find_by_username(@usrNam.downcase)
      render :text => @user.avatar.url( params[:style].blank? ? :tiny : params[:style] )
    else
      render_error(404,"User not found")
    end
  end

  private

  def users
puts params
    @users ||= User.by_option(params[:option], current_user).by_category(params[:category])
      .without_user(current_user).paginate(per_page: params[:per_page] ||= 2, page: params[:page])
  end

  def user
    @user ||= User.find(params[:id])
  end

  def items
    items = params[:saved] ? Item.saved_by(user) : user.items
    per_page = 2
    if params[:item_id].present?
      item = Item.find(params[:item_id])
      per_page = [items.index(item) + 1, per_page].max
    end
    @items ||= items.between(params).paginate(per_page: per_page, page: params[:page])
  end
end
