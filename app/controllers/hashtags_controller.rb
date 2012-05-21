class HashtagsController < ApplicationController
  
  # Create hashtag
  # * *Request*    :
  #   - POST /hashtags/create
  # * *Args*    :
  #   - :hashtag_value -> Hashtag value
  #   - :item_id -> id of the item the hashtags is to be added to
  def create
    authenticate_user!
    
    params[:hashtag_value].gsub(/[^[:alnum:]]/,'')

    # todo tell user when parent_id or status not 1
    
    begin
      @item = Item.joins(:post,:user) \
                  .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                  .where("items.id = #{params[:item_id]} AND (ISNULL(items.parent_id) || items.parent_id = 0) AND items.status = 1").first!
    rescue
      puts "something bad happened here, error: #{$!}"
      return render_error(404,"Item not found")
    end
                 
    if !@item.post.hashtags_allowed
      return render_error(403, "Hashtags not allowed")   
    elsif @item.user.private
      authenticate_user!
      if !current_user.subscribed_to(@item.user)
        return render_error(404,"Item not found")
      end
    end
    
    @hashtag_value = HashtagValue.find_or_create_by_value(params[:hashtag_value])
    if @hashtag_value.blank?
      return render_error(500,"Failed to create hashtag")
    end
    
    @hashtag = Hashtag.new({:user_id => current_user.id, :post_id => @item.post.id, :hashtag_value_id => @hashtag_value.id})
    
    if !@hashtag.save
      return render_error(500,"Failed to create hashtag")
    end
    return render :partial => 'hashtag', :locals => {:hashtag => @hashtag}, :status => 201
  end
  
  # Search hashtags
  # * *Request*    :
  #   - GET /hashtags/search
  # * *Args*    :
  #   - :search -> Search parameter
  def search
    @hashtags = Hashtag.joins(:hashtag_values).where("hashtags.status = 1 AND hashtag_values.value LIKE %?%",params[:search])
  end
  
  # Show popular hashtags
  # * *Request*    :
  #   - GET /hashtags/popular
  # * *Args*    :
  #   - void
  def show_popular
    @hashtags = Hashtag.where("status = 1 AND created_at > ?",5.day.ago).order("hashtag_value_id DESC").group("hashtag_value_id")
  end
  
  # Delete hashtag
  # * *Request*    :
  #   - DELETE /hashtags/:id
  # * *Args*    :
  #   - :id -> User id
  def destroy
    authenticate_user!
    @hashtag = Hashtag.joins(:post,:user) \
                      .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                      .where("hashtags.status = 1 AND hashtags.id = ? AND (hashtags.user_id = ? OR posts.user_id = ?)",params[:id],current_user.id,current_user.id) \
                      .readonly(false).first!
    if @hashtag.deactivate
      render :json => "Hashtag successfully deleted", :status => 200
    else
      render_error(500,"There was a problem deleting the hashtag")
    end  
  end
end
