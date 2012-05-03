class TimelinesController < ApplicationController
  
  def home 
    if user_signed_in?
      redirect_to "/home.html"
    else
      redirect_to "/login"
    end
  end
  # Fetch up to 50 items of current user and that of his/her subscriptions 
  # * *Request*    :
  #   - GET /timelines
  # * *Args*    :
  #   - :above -> Highest id to obtain items between
  #   - :below -> Lowest id to obtain items between
  #   - :limit -> Number of items to return
  def index
    authenticate_user!
    above_below_statement = ""
    if !params[:above].blank? || !params[:below].blank?
      if !params[:above].blank? && !params[:below].blank?
        above_below_statement = "AND items.id BETWEEN #{params[:above]} AND #{params[:below]}"
      elsif params[:above].blank?
        return render_error(406,"An above value is required if below is set")  
      elsif params[:below].blank?
        return render_error(406,"A below value is required if above is set")
      end
    end
    
    if !params[:limit].blank? && params[:limit] >= 50
      return render_error(406,"Limit must be less than or equal to 50")
    end
    

    if (current_user)
        logger.debug "xcurrent_user:" 
    end

    limit = params[:limit].blank? ? 20 : params[:limit]
    @items = Item.joins(:post,:user,"INNER JOIN subscriptions ON subscriptions.user_id = items.user_id AND subscriptions.status = 1")
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1")
                 .where("items.status = 1 AND (subscriptions.follower_id = ? OR items.user_id = ?) #{above_below_statement}",current_user.id,current_user.id)
                 .order("items.created_at DESC")
                 .group("items.id")
                 .limit(limit)
  end
  
  # Fetch up to 50 items of a specified user
  # * *Request*    :
  #   - GET /timelines/users/:id
  # * *Args*    :
  #   - :id -> User id
  #   - :above -> Highest id to obtain items between
  #   - :below -> Lowest id to obtain items between
  #   - :limit -> Number of items to return  
  def show_user
    @user = User.find(params[:id])
    
    if @user.private
      authenticate_user!
      if !current_user.subscribed_to(@user)
        return render_error(404,"User not found")
      end
    end
    
    if !params[:above].blank? || !params[:below].blank?
      if !params[:above].blank? && !params[:below].blank?
        above_below_statement = "AND items.id BETWEEN #{params[:above]} AND #{params[:below]}"
      elsif params[:above].blank?
        return render_error(406,"An above value is required if below is set")  
      elsif params[:below].blank?
        return render_error(406,"A below value is required if above is set")  
      end
    end
    
    if !params[:limit].blank? && params[:limit] >= 50
      return render_error(406,"Limit must be less than or equal to 50")
    end
    
    limit = params[:limit].blank? ? 20 : params[:limit]
    @items = Item.joins(:post,:user) \
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                 .where("items.status = 1 AND items.user_id = ? #{above_below_statement}",@user.id) \
                 .order("items.created_at DESC") \
                 .group("items.id") \
                 .limit(limit)
     render :index
  end

  # Fetch up to 50 of the most recent items posted
  # * *Request*    :
  #   - GET /timelines/recent
  # * *Args*    :
  #   - :above -> Highest id to obtain items between
  #   - :below -> Lowest id to obtain items between
  #   - :limit -> Number of items to return
  def show_recent
    if !params[:above].blank? || !params[:below].blank?
      if !params[:above].blank? && !params[:below].blank?
        above_below_statement = "AND items.id BETWEEN #{params[:above]} AND #{params[:below]}"
      elsif params[:above].blank?
        return render_error(406,"An above value is required if below is set")  
      elsif params[:below].blank?
        return render_error(406,"A below value is required if above is set")  
      end
    end
    
    if !params[:limit].blank? && params[:limit] >= 50
      return render_error(406,"Limit must be less than or equal to 50")
    end
    
    limit = params[:limit].blank? ? 20 : params[:limit]
    @items = Item.joins(:post,:user) \
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                 .where("items.status = 1 AND users.private != 1") \
                 .order("items.created_at DESC") \
                 .group("items.id") \
                 .limit(limit)
     render :index

  end  

  # Fetch up to 50 items that match hashtag name
  # * *Request*    :
  #   - GET /timelines/hashtags/:name
  # * *Args*    :
  #   - :name -> Hashtag value
  #   - :limit -> Number of items to return    
  def show_hashtags
    limit = params[:limit].blank? ? 20 : params[:limit]
    @items = Item.joins(:post,:user,:hashtags,:hashtag_values) \
                  .where("items.status = 1 AND hashtag_values.value = ?",params[:name]) \
                  .order("items.created_at DESC") \
                  .group("items.id") \
                  .limit(limit)
    render :index              
  end
  
end
