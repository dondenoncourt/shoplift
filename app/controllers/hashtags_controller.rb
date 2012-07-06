class HashtagsController < ApplicationController
  
  # =begin apidoc
  # url:: /hashtags/create.json
  # method:: POST
  # access:: FREE
  # return:: hashtag_value object
  # param:: item_id:int - id of the item the hashtags is to be added to
  # param:: hashtag_value:string - Hashtag Value
  # output:: json
  # {"id":6,"value":"hat"}
  # ::output-end::
  # Create hashtag
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:poopydiaper -d "item_id=1" -d "hashtag_value=hat" localhost:3000/hashtags/create.json</pre>  
  # =end    
  def create
    authenticate_user!
    
    params[:hashtag_value].gsub(/[^[:alnum:]]/,'')

    # todo tell user when parent_id or status not 1
    
    begin
      @item = Item.joins(:post,:user) \
                  .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                  .where("items.id = #{params[:item_id]} AND items.status = 1").first!
                  #.where("items.id = #{params[:item_id]} AND (ISNULL(items.parent_id) || items.parent_id = 0) AND items.status = 1").first!
    rescue
      puts "error: #{$!}"
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
      return render_error(500,"Failed to create hashtag: "+params[:hashtag_value]+' '+@hashtag.errors[:hashtag_value_id][0])
    end
    return render :partial => 'hashtag', :locals => {:hashtag => @hashtag}, :status => 201
  end

  # =begin apidoc
  # url:: /hashtags/search.json?search=:search
  # method:: GET
  # access:: FREE
  # return:: hashtags list 
  # param:: search:string - search string value to be used on LIKE clause against table hashtag_values
  # output:: json
  # [{"created_at":"2012-07-05T15:15:42-05:00","hashtag_value_id":8,"id":10,"post_id":1,"status":1,"updated_at":"2012-07-05T15:15:42-05:00","user_id":12}]
  # ::output-end::
  # Search hashtags
  # <br/><br/>Notes:<pre>curl -X GET --user aaronbartell@gmail.com:poopydiaper localhost:3000/hashtags/search?search=hat</pre>  
  # =end     
  def search
    @hashtags = Hashtag.joins(:hashtag_value).where("hashtags.status = 1 AND hashtag_values.value LIKE '%#{params[:search]}%'")
    render :json => @hashtags, :status => 200
  end
  
  # =begin apidoc
  # url:: /hashtags/popular.json
  # method:: GET
  # access:: FREE
  # return:: hashtags list
  # output:: json
  # [{"created_at":"2012-07-05T15:15:42-05:00","hashtag_value_id":8,"id":10,"post_id":1,"status":1,"updated_at":"2012-07-05T15:15:42-05:00","user_id":12},{"created_at":"2012-07-05T15:01:54-05:00","hashtag_value_id":7,"id":9,"post_id":1,"status":1,"updated_at":"2012-07-05T15:01:54-05:00","user_id":11},{"created_at":"2012-07-05T14:57:17-05:00","hashtag_value_id":6,"id":8,"post_id":1,"status":1,"updated_at":"2012-07-05T14:57:17-05:00","user_id":11}]
  # ::output-end::
  # Show popular hashtags
  # <br/><br/>Notes:<pre>curl -X GET --user aaronbartell@gmail.com:poopydiaper localhost:3000/hashtags/popular.json</pre>  
  # =end
  def show_popular
    @hashtags = Hashtag.where("status = 1 AND created_at > ?",5.day.ago).order("hashtag_value_id DESC").group("hashtag_value_id")
    render :json => @hashtags, :status => 200
  end
  
  # =begin apidoc
  # url:: /hashtags/:id/delete.json
  # method:: GET
  # access:: FREE
  # return:: hashtags list
  # param:: id:int - id of hashtag to be deleted
  # output:: json
  # {"created_at":"2012-07-05T15:15:42-05:00","hashtag_value_id":8,"id":10,"post_id":1,"status":0,"updated_at":"2012-07-05T15:20:30-05:00","user_id":12}
  # ::output-end::
  # Delete hashtag
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:poopydiaper localhost:3000/hashtags/10/delete.json</pre>  
  # =end  
  def destroy
    authenticate_user!
    @hashtag = Hashtag.joins(:post,:user) \
                      .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                      .where("hashtags.status = 1 AND hashtags.id = ? AND (hashtags.user_id = ? OR posts.user_id = ?)",params[:id],current_user.id,current_user.id) \
                      .readonly(false).first!
    if @hashtag.deactivate
      render :json => @hashtag, :status => 200
    else
      render_error(500,"There was a problem deleting the hashtag")
    end  
  end
end
