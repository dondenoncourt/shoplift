class UsersController < ApplicationController

  # Fetch information about user, searched by id or username
  # * *Request*    :
  #   - GET /users/:id
  # * *Args*    :
  #   - :id -> User id
  #   - :username -> Username
  def show
    
    logger.debug params
    logger.debug params['username']
    if params[:identifier] == "user_id"
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
        render :partial => 'user', :locals => {:user => @user}
      end
    else
      render :partial => 'user', :locals => {:user => @user}  
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
    if @user.deactivate
      return render :json => @user, :status => 200
    else
      return_error_messages(@user,"Failed to delete user")
    end
  end
  
end
