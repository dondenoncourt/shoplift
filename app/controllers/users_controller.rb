class UsersController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, :only => [:validate_email]
  respond_to :json

  def index

    users = if email = params[:email]
      # TODO: find a better way for ember to lookup email
      User.find_all_by_email(email)
    elsif ids = params[:ids]
      User.where(:id => ids)
    else
      User.find(:all)
    end

    respond_with users
  end


  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @user, status: 200 }
    end
  end

  def validate_username
    if @user = User.find_by_username(params[:username].downcase)
      render :partial => "user", :locals => {:user => @user}
    else
      render_error(404,"User not found")
    end
  end

  def validate_email
    if @user = User.find_by_email(params[:email].downcase)
      render :partial => "user", :locals => {:user => @user}
    else
      render_error(404,"User not found #{params[:email]} x")
    end
  end

  def update
    ## Check if user is updating themselve or another (must be admin) ##
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      render json: @user
    else
      return_error_messages(@user,"Failed to update user")
    end
  end

  def destroy
    
  end

  def avatar
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

  def following
    render json: {
      :is_following => current_user.follows?(params[:id])
    }.to_json
  end

  def followed
    render json: {
      is_followed: current_user.follwed?(params[:id])
    }.to_json
  end

  def whoami
    user = current_user.id
    json = {:user => user}.to_json
    render :json => json
  end

  private

  def users
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
