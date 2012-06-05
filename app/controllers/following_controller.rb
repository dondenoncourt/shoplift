class FollowingController < ApplicationController
  before_filter :authenticate_user!

  # GET /users/:user_id/following(.:format)
  def index
    @user = User.find(params[:user_id])
    @users = @user.followees.paginate(per_page: 2, page: params[:page])
    if request.xhr?
      render partial: @users
    end
  end

end
