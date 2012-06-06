class FollowersController < ApplicationController
  before_filter :authenticate_user!

  # =begin apidoc
  # url:: /users/:user_id/followers.json
  # method:: GET
  # access:: FREE
  # return:: user's followers
  # param:: user_id:int - the id of the user
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
  # Get a list of the user's followers
  # =end
  def index
    @user = User.find(params[:user_id])
    @users = @user.followers.paginate(per_page: 2, page: params[:page])
    if request.xhr?
      render partial: @users
    else
      respond_to do |format|
        format.html
        format.json { render json: @users }
      end
    end
  end

end
