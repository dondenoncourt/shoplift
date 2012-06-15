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
    @item = Item.find(params[:item_id])

    if @item.user.private && !current_user.subscribed_to(@item.user)
      return render_error(404,"Item not found")
    end

    @set_aside = @item.set_asides.where(:user_id => current_user.id, :status => 1).first_or_create
    if @set_aside.persisted?
      if request.xhr?
        render :json => @set_aside, :locals => {:item => @set_aside.item}, :status => 201
      else
        render :partial => 'items/item', :locals => {:item => @set_aside.item}, :status => 201
      end
    else
      return_error_messages(@set_asides,"Item failed to save")
    end
  end

  # Delete set aside
  # * *Request*    :
  #   - DELETE /set_asides/items/:id
  # * *Args*    :
  #   - :id -> id
  def destroy
    @set_aside = SetAside.where("id = ?",params[:id]).first!
    if @set_aside.delete
      render :json => '{"dummy":"dummy"}', :status => 200
    else
      return_error_messages(@set_aside,"Set aside delete failed")
    end
  end

end
