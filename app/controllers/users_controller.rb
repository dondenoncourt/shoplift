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
  # [
  #   {
  #     "avatar_content_type":"image/jpeg","avatar_file_name":"bella_4.5_mths.jpg","avatar_file_size":151209,
  #     "avatar_updated_at":"2012-05-16T19:05:57-05:00","biography":"I like computers","birthdate":"1987-05-24",
  #     "count_of_followers":1,"count_of_hashtags":0,"count_of_posts":0,"country":null,"created_at"
  #     :"2011-12-19T23:04:53-06:00","email":"mark@38media.net","first_name":"Mark","full_name":"Mark A. Roseboom",
  #     "hometown":"Boston, MA","id":1,"last_name":"Roseboom","latitude":null,"longitude":null,"missing":null,
  #     "notify_missing":null,"notify_new_follower":null,"notify_relift":null,"private":false,"sex":true,"status":1,
  #     "updated_at":"2012-02-09T10:50:43-06:00","url":"http://38media.net","username":"mroseboom","vanity_url":null,
  #     "zipcode":null
  #   }
  # ]
  # ::output-end::
  # Get a list of all users in the system with pagination.  Defaults to 2 per page
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
  # {
  #   "extract":
  #     {
  #       "id":18,"email":"bozo@test.com","username":"bozo@test.com","full_name":"Bozo Clown","first_name":null,
  #       "last_name":null,"vanity_url":null,"country":"United States","biography":null,"notify_new_follower":null,
  #       "notify_relift":null,"notify_missing":null,"hometown":null,"zipcode":"","sex":null
  #     },
  #   "sex":"Female","avatar_url_small":"/assets/avatars/small/missing.png",
  #   "avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":5
  # }
  # ::output-end::
  # Get the user's information
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

  # Validate a specified username
  # * *Request*    :
  #   - GET /users/validate_username/:username
  # * *Args*    :
  #   - :username -> Username
  def validate_username
    if @user = User.find_by_username(params[:username].downcase)
      render :partial => "user", :locals => {:user => @user}
    else
      render_error(404,"User not found")
    end
  end

  # Create user
  # * *Request*    :
  #   - POST /users
  # * *Args*    :
  #   - :user -> Array of user data
  def create
    @user = User.new(params[:user])
    if @user.save
      render :partial => 'user', :locals => {:user => @user}, :status => 201
    else
      return_error_messages(@user,"Failed to create user")
    end
  end

  # Update user
  # * *Request*    :
  #   - PUT /users/:id
  # * *Args*    :
  #   - :id -> User id
  #   - :user -> Array of user data
  def update
    ## Check if user is updating themselve or another (must be admin) ##
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      render :partial => 'user', :locals => {:user => @user}
    else
      return_error_messages(@user,"Failed to update user")
    end
  end

  # Delete user
  # * *Request*    :
  #   - DELETE /users/:id
  # * *Args*    :
  #   - :id -> User id
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

  private

  def users
    @users ||= User.by_option(params[:option], current_user).by_category(params[:category]).without_user(current_user).paginate(per_page: 2, page: params[:page])
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
