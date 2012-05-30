class UsersController < ApplicationController

  def index
    users
    if request.xhr?
      render partial: users
    end
  end

  # Fetch information about user, searched by id or username
  # * *Request*    :
  #   - GET /users/:id/info
  # * *Args*    :
  #   - :id -> User id
  def info
    authenticate_user!
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :partial => 'user', :locals => {:user => @user} }
    end
  end

  # Fetch information about user, searched by id or username
  # * *Request*    :
  #   - GET /users/:id
  # * *Args*    :
  #   - :id -> User id
  #   - :username -> Username
  def show
    if params[:id]
      @user = User.find(params[:id])
    elsif params[:identifier] == "username"
      @user = User.find_by_username(params['username'])
    end

    if request.xhr?
      render partial: items
    else
      items
      if @user.private?
        authenticate_user!
        if !current_user.subscribed_to(@user)
          render_error(404,"Item not found")
        else
          respond_to do |format|
            format.html
            format.json { render :partial => 'user', :locals => {:user => @user} }
          end
        end
      else
        respond_to do |format|
          format.html
          format.json { render :partial => 'user', :locals => {:user => @user} }
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
    authenticate_user!
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
    authenticate_user!
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
    # we should probably remove the current user from this list
    @users ||= User.by_option(params[:option]).paginate(per_page: 2, page: params[:page])
  end

  def user
    @user ||= User.find(params[:id])
  end

  def items
    items = user.items.between(params).paginate(per_page: 2, page: params[:page])
    items = items.saved_by(user) if params[:saved]
    @items ||= items
  end
end
