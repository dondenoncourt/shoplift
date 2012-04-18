class SetAsidesController < ApplicationController
  before_filter :authenticate_user!
  
  # Fetch all set asides for current user
  # * *Request*    :
  #   - GET /set_asides
  # * *Args*    :
  #   - void
  def index
    @set_asides = SetAside.joins(:post,:item,:user) \
                          .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                          .joins("INNER JOIN users AS item_users on items.user_id = item_users.id AND users.status = 1") \
                          .where("set_asides.user_id = ? AND set_asides.status = 1",current_user.id) \
                          .group("items.id")
  end
  
  # Create set aside
  # * *Request*    :
  #   - POST /set_asides/items/:id
  # * *Args*    :
  #   - :id -> Item id
  def create
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = users.id AND users.status = 1") \
                .where(:id => params[:item_id], :status => 1).first!

    if @item.user.private
      authenticate_user!
      if !current_user.subscribed_to(@item.user)
        return render_error(404,"Item not found")
      end
    end
    
    # Check that the item is not already in the user's set asides
    if SetAside.where("item_id = ? AND user_id = ? AND status = 1", params[:item_id], current_user.id).first
      return render_error(406,"Item is already in your set asides")
    end
    
    @set_aside = SetAside.new({ :item_id => params[:item_id], :user_id => current_user.id })
    if @set_aside.save
      render :partial => 'items/item', :locals => {:item => @set_aside.item}, :status => 201
    else
      return_error_messages(@set_asides,"Side aside save failed")
    end
  end
  
  # Delete set aside
  # * *Request*    :
  #   - DELETE /set_asides/items/:id
  # * *Args*    :
  #   - :id -> Item id
  def destroy
    @set_aside = SetAside.where("item_id = ? AND user_id = ? AND status = 1",params[:id],current_user.id).first!
    if @set_aside.deactivate
      render :json => "Set aside successfully deleted", :status => 200
    else
      return_error_messages(@set_aside,"Set aside delete failed")
    end
  end

end
