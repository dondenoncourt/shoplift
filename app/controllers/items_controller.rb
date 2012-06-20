class ItemsController < ApplicationController
  require 'open-uri'
  
  # =begin apidoc
  # url:: /items/:id.json
  # method:: GET
  # access:: FREE
  # return:: item
  # param:: id:int - item id
  # output:: json
  # {"id":1,"item_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"},{"id":20,"value":"tie"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157"},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]}
  # ::output-end::
  # Fetch item
  # <br/><br/>Notes:<pre></pre>  
  # =end  
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

  # =begin apidoc
  # url:: /items/:id/visit
  # method:: GET
  # access:: FREE
  # return:: item URL
  # param:: id:int - item id
  # output:: json
  # http://www.jcrew.com/index.jsp
  # ::output-end::
  # Fetch item URL
  # <br/><br/>Notes:<pre></pre>  
  # =end  
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

  # =begin apidoc
  # url:: /items/search.json?search=:search
  # method:: GET
  # access:: FREE
  # return:: items list
  # param:: search:string - value to search for in posts.name, posts.description, posts.brand or posts.retailer
  # output:: json
  # {"timeline":[{"id":1,"item_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","set_aside":{"created_at":"2012-06-20T12:28:44-05:00","id":18,"item_id":1,"status":1,"updated_at":"2012-06-20T12:28:44-05:00","user_id":12},"hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":null,"sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":1},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]},{"id":4,"item_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"}],"user":{"extract":{"id":2,"email":"patrick@38media.net","username":"camachgk","full_name":"Patrick Camacho","first_name":"Patrick","last_name":"Camacho","vanity_url":"http://38media.net","country":"United States","biography":"I like dogs","notify_new_follower":true,"notify_relift":false,"notify_missing":"daily","hometown":"Waltham, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/2/headless.jpg?1337213827","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/2/headless.jpg?1337213827","followee_count":1},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]}]}
  # ::output-end::
  # Search items
  # <br/><br/>Notes:<pre></pre>  
  # =end
  def search
    @items = Item.joins(:post,:user) \
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                 .joins("LEFT OUTER JOIN brands AS b on posts.brand_id = b.id") \
                 .where("items.status = 1 AND (posts.name LIKE '%#{params[:search]}%' OR posts.description LIKE '%#{params[:search]}%' OR b.name LIKE '%#{params[:search]}%') OR posts.retailer LIKE '%#{params[:search]}%'")
    render :template => 'timelines/index', :locals => {:items => @items}
  end

  # =begin apidoc
  # url:: /items.json
  # method:: POST
  # access:: FREE
  # return:: item object
  # param:: item object
  # output:: json
  # 
  # ::output-end::
  # Create item
  # <br/><br/>Notes:<pre></pre>  
  # =end
 
  # TODO finish putting curl example in here.
  # 
  # * *Request*    :
  #   - POST /items
  # * *Args*    :
  #   - :item -> Array of item details
  def create
    authenticate_user!
    post = {:user_id => current_user.id}
    post_include = ["name", "description", "retailer", "url", "price", "comment"]#, "hashtags_allowed"]

    # puts "HACK: stuff values in required attributes"
    params[:name] ||= 'TODO get name in bookmarklet.js'

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
    if params[:image] || params[:item][:image]
      image = params[:image] ||= params[:item][:image]
      retailer = params[:retailer] ||= params[:item][:retailer]
      image = "http://"+retailer+image if !image.include? 'http:'
      @post.photo = open(image.gsub(/\s/, "%20")) 
      @post.brand = Brand.find_or_create_by_name(params[:item][:brand])
      if !@post.save
        return return_error_messages(@post,"Failed to create item")
      end
    end

    @item = Item.new({:user_id => current_user.id, :post_id => @post.id, :comment => @post.comment})
    if @item.save
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.json { render :partial => 'item', :locals => {:item => @item}, :status => 201 }
      end
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

    @new_item = Item.new({:user_id => current_user.id, :post_id => @item.post.id, :item_id => @item.id, :comment => params[:comment]})
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
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where("items.id = ? AND items.user_id = ? AND ISNULL(items.item_id) AND items.status = 1",
                        params[:id],current_user.id).first!

    post = {:user_id => current_user.id}
    post_include = ["name", "description", "retailer", "url", "price", "comment", "hashtags_allowed"]

    if params[:item].blank?
      post_include.each do |element|
        post = post.merge({element => params[element]})
      end
      post[:brand]= Brand.find_or_create_by_name(params[:brand])
    else
      post_include.each do |element|
        post = post.merge({element => params[:item][element]})
      end
      post[:brand]= Brand.find_or_create_by_name(params[:item][:brand])
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
      if !@item.item_id.blank?
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

  def image
    @item = Item.find(params[:id])
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
