class ItemsController < ApplicationController

  # Fetch item
  # * *Request*    :
  #   - GET /items/:id
  # * *Args*    :
  #   - :id -> Item id
  def show
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where(:id => params[:id], :status => 1).readonly(false).first!
    if validate_item_results?
      @item.increment!(:views)
      @item.post.increment!(:views)
      render :partial => 'item', :locals => {:item => @item}, :status => 200
    else
      render_error(404,"Item not found")
    end
  end
  
  # Fetch item URL
  # * *Request*    :
  #   - GET /items
  # * *Args*    :
  #   - :id -> Item id
  def visit
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where(:id => params[:id], :status => 1).readonly(false).first!
    if validate_item_results?
      @item.increment!(:visits)
      @item.post.increment!(:visits)
      render :json => @item.post.url, :status => 200
    else
      render_error(404,"Item not found")
    end
  end
  
  # Search items
  # * *Request*    :
  #   - GET /items/search
  # * *Args*    :
  #   - :search -> Search parameter
  def search
    @items = Item.joins(:post,:user) \
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                 .where("items.status = 1 AND (posts.name LIKE '%#{params[:search]}%' OR posts.description LIKE '%#{params[:search]}%' OR posts.brand LIKE '%#{params[:search]}%') OR posts.retailer LIKE '%#{params[:search]}%'")
    render :template => 'timelines/index', :locals => {:items => @items}
  end
  
  # Create item
  # * *Request*    :
  #   - POST /items
  # * *Args*    :
  #   - :item -> Array of item details
  def create
    authenticate_user!
    post = {:user_id => current_user.id}
    post_include = ["name", "description", "brand", "retailer", "url", "price", "comment", "hashtags_allowed"]
    
    if params[:item].blank?
      post_include.each do |element| 
        post = post.merge({element => params[element]})
      end
    else
      post_include.each do |element| 
        post = post.merge({element => params[:item][element]})
      end
    end
    
    @post = Post.new(post)
    if !@post.save
      return return_error_messages(@post,"Failed to create item")
    end
                
    @item = Item.new({:user_id => current_user.id, :post_id => @post.id})
    if @item.save
      render :partial => 'item', :locals => {:item => @item}, :status => 201
    else
      return_error_messages(@item,"Failed to create item")
    end
  end
  
  # Relift item
  # * *Request*    :
  #   - POST /items/:id/relift
  # * *Args*    :
  #   - :id -> Item id
  def relift
    authenticate_user!
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where(:id => params[:id], :status => 1).readonly(false).first!

    if !validate_item_results?
      return render_error(404,"Item not found")
    end
    
    @new_item = Item.new({:user_id => current_user.id, :post_id => @item.post.id, :parent_id => @item.id})
    if @new_item.save
      @item.increment!(:relifts)
      @item.post.increment!(:relifts)
      render :partial => 'item', :locals => {:item => @new_item}, :status => 201
    else
      return_error_messages(@new_item,"Failed to relift item")
    end 
  end 
  
  # Update item
  # * *Request*    :
  #   - PUT /items
  # * *Args*    :
  #   - :item -> Array of item details
  def update
    authenticate_user!
    @item
    begin
    # denoncourt, was ISNULL(items.parent_id) but null wasn't used
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where("items.id = ? AND items.user_id = ? \
                        AND items.parent_id = 0 \
                        AND items.status = 1", params[:id],current_user.id).first!
    rescue ActiveRecord::RecordNotFound
        puts "record not found"
    end 
                    
    post = {:user_id => current_user.id}
    post_include = ["name", "description", "brand", "retailer", "url", "price", "comment", "hashtags_allowed"]
    
    if params[:item].blank?
      post_include.each do |element| 
        post = post.merge({element => params[element]})
      end
    else
      post_include.each do |element| 
        post = post.merge({element => params[:item][element]})
      end
    end
    
    if @item.post.update_attributes(post)
      render :partial => 'item', :locals => {:item => @item}, :status => 200
    else
      return_error_messages(@item,"Failed to update item")
    end 
  end
  
  # Delete item
  # * *Request*    :
  #   - DELETE /items
  # * *Args*    :
  #   - :id -> Item id
  def destroy
    authenticate_user!
     @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where("items.id = ? AND items.user_id = ? AND items.status = 1",params[:id],current_user.id) \
                .readonly(false).first!
    
    if @item.deactivate
      # Item is a relift and post should not be deactivated
      if !@item.parent_id.blank?
        render :json => "Item successfully deleted", :status => 200
      else
        if @item.post.deactivate
          render :json => "Item successfully deleted", :status => 200
        else
          return_error_messages(@item.post,"Failed to delete item")
        end    
      end    
    else
      return_error_messages(@item,"Failed to delete item")
    end
  end
  
  protected
  
  # Validates whether user has access to item
  # * *Args*    :
  #   - void
  def validate_item_results?
    if @item.user.private
      authenticate_user!
      if !current_user.subscribed_to(@item.user)
        return false
      end
    end
    return true
  end
  
end
