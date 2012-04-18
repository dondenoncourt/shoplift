class StatisticsController < ApplicationController
  before_filter :authenticate_user!
  
  # Fetch statistics for users items
  # * *Request*    :
  #   - GET /statistics/users/:id
  # * *Args*    :
  #   - :id -> User id
  def show_user
    
    @user = User.where(:id => params[:id], :status => 1).first!
    
    if @user.private
      authenticate_user!
      if !current_user.subscribed_to(@user)
        return render_error(404,"User Not Found")
      end
    end
    
    @items = Item.joins(:post,:user) \
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                 .where("items.user_id = ? and items.status = 1",@user.id)
  end
  
  # Fetch statistics for items
  # * *Request*    :
  #   - GET /statistics/items/:id
  # * *Args*    :
  #   - :id -> Item id
  def show_item
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where(:id => params[:id], :status => 1).first!
    
    if @item.user.id != current_user.id
      return render_error(404,'Item Not Found')
    end
  end
  
end
