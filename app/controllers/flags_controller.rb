class FlagsController < ApplicationController
  before_filter :authenticate_user!
  
  # Fetch all flags for current user
  # * *Request*    :
  #   - GET /flags
  # * *Args*    :
  #   - :limit -> String to be returned
  def index
    limit = params[:limit].blank? ? 20 : params[:limit]
    
    @post_flags = PostFlag.joins(:items,:user) \
                          .where("post_flags.status = 1 AND items.user_id = #{current_user.id} AND posts.user_id = #{current_user.id}") \
                          .order("items.created_at DESC").limit(limit)
                          
     @hashtag_flags = HashtagFlag.joins(:items,:user) \
                                 .where("hashtag_flags.status = 1 AND items.user_id = #{current_user.id} AND posts.user_id = #{current_user.id}") \
                                 .order("items.created_at DESC").limit(limit)
                      
    raise ActiveRecord::RecordNotFound unless !@post_flags.blank? || !@hashtag_flags.blank?
  end
  
  # Create flag for item
  # * *Request*    :
  #   - POST /flags/items/:id
  # * *Args*    :
  #   - :id -> Item id
  #   - :flag_type_id -> FlagType id
  #   - :post_id -> Post id
  #   - :user_id -> User id
  def create_item
    @post_flag = PostFlag.new(:flag_type_id => params[:flag_type_id], :post_id => Item.find(params[:id]).post.id, :user_id => current_user.id)
    if @post_flag.save
      render :partial => 'post_flags/post_flag', :locals => {:post_flag => @post_flag}, :status => 201
    else
      return_error_messages(@post_flag,"Could not create item flag")
    end
  end
  
  # Create flag for hashtag
  # * *Request*    :
  #   - POST /flags/hashtags/:id
  # * *Args*    :
  #   - :id -> Hashtag id
  #   - :flag_type_id -> FlagType id
  #   - :post_id -> Post id
  #   - :user_id -> User id
  def create_hashtag
    @hashtag_flag = HashtagFlag.new(:flag_type_id => params[:flag_type_id], :hashtag_id => params[:id], :user_id => current_user.id)
    if @hashtag_flag.save
      render :partial => 'hashtag_flags/hashtag_flag', :locals => {:hashtag_flag => @hashtag_flag}, :status => 201
    else
      return_error_messages(@hashtag_flag,"Could not create hashtag flag")
    end
  end
  
end
