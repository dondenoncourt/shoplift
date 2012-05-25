class UsersController < ApplicationController
  layout 'standard', :except => [:recommended]


  # Fetch information about user, searched by id or username
  # * *Request*    :
  #   - GET /users/:id
  # * *Args*    :
  #   - :id -> User id
  #   - :username -> Username
  def show

    logger.debug params
    logger.debug params['username']
    if params[:id]
      @user = User.find(params[:id])
    elsif params[:identifier] == "username"
      @user = User.find_by_username(params['username'])
    else
      return render_error(404,"User not found")
    end

    if @user.private?
      authenticate_user!
      if !current_user.subscribed_to(@user)
        render_error(404,"Item not found")
      else
        respond_to do |format|
          format.html # show.html.erb
          format.json { render :partial => 'user', :locals => {:user => @user} }
        end
      end
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :partial => 'user', :locals => {:user => @user} }
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

  # Recommended users
  # * *Request*    :
  #   - GET /recommended
  def recommended
    authenticate_user!
    naive_suggestions
  end

  # Staff Picks of users
  # * *Request*    :
  #   - GET /staff_picks
  def staff_picks
    authenticate_user!
    naive_suggestions
  end

  # Popular users
  # * *Request*    :
  #   - GET /popular
  def popular
    authenticate_user!
    naive_suggestions
  end

  # Trending users
  # * *Request*    :
  #   - GET /trending
  def trending
    authenticate_user!
    naive_suggestions
  end

  # favorite users local to requestor
  # * *Request*    :
  #   - GET /staff_picks
  def local_favorites
    authenticate_user!
    naive_suggestions
  end

  # friends of users
  # * *Request*    :
  #   - GET /friends
  def friends
    authenticate_user!
    naive_suggestions
  end

  private 

  def naive_suggestions
    @users = User.where('status = 1').order("RAND()")
    respond_to do |format|
      format.html { render :partial => 'suggestions', :locals => {:users => @users} }
      format.json #{ render :partial => 'user', :locals => {:user => @user} }
    end
  end
end
