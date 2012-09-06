class ItemsController < ApplicationController
  layout nil, :only => [:email]
  require 'open-uri'
  

  def index
    @items = Item.joins(:post,:user,:subscriptions)
                 .joins("LEFT JOIN user_item_views ON user_item_views.user_id = subscriptions.follower_id AND user_item_views.item_id = items.id")
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1")
                 .where("items.status = 1 AND (subscriptions.follower_id = ? )",current_user.id)
                 .between(params)
                 .group("items.id")
                 .order("user_item_views.created_at ASC, items.created_at DESC")
                 .paginate(per_page: params[:per_page].present? ? params[:per_page]: 6, page: params[:page])
    @items.each {|i| UserItemView.create({user_id:current_user.id, item_id:i.id})}

    #render partial: @items
    render :partial => 'items', :locals => {:items => @items}
  end

  # =begin apidoc
  # url:: /items/:id.json
  # method:: GET
  # access:: FREE
  # return:: item
  # param:: id:int - item id
  # output:: json
  # {"id":1,"parent_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"},{"id":20,"value":"tie"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157"},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]}
  # ::output-end::
  # Fetch item
  # <br/><br/>Notes:<pre>curl -X GET --user aaronbartell@gmail.com:poopydiaper localhost:3000/items/1.json</pre>  
  # =end  
  def show
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where(:id => params[:id], :status => 1).readonly(false).first!
    if validate_item_results?
      @item.increment!(:views)
      @item.post.increment!(:views)
      respond_to do |format|
        format.html { render 'show'}
        format.json { render :partial => 'item', :locals => {:item => @item}, :status => 200 }
      end
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
  # <br/><br/>Notes:<pre>curl -X GET --user aaronbartell@gmail.com:poopydiaper localhost:3000/items/1/visit</pre>  
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
  # {"timeline":[{"id":1,"parent_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","set_aside":{"created_at":"2012-06-20T12:28:44-05:00","id":18,"parent_id":1,"status":1,"updated_at":"2012-06-20T12:28:44-05:00","user_id":12},"hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":null,"sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":1},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]},{"id":4,"parent_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"}],"user":{"extract":{"id":2,"email":"patrick@38media.net","username":"camachgk","full_name":"Patrick Camacho","first_name":"Patrick","last_name":"Camacho","vanity_url":"http://38media.net","country":"United States","biography":"I like dogs","notify_new_follower":true,"notify_relift":false,"notify_missing":"daily","hometown":"Waltham, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/2/headless.jpg?1337213827","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/2/headless.jpg?1337213827","followee_count":1},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]}]}
  # ::output-end::
  # Search items
  # <br/><br/>Notes:<pre>curl -X GET --user aaronbartell@gmail.com:poopydiaper localhost:3000/items/search.json?search=Item</pre>  
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
  # {"id":80,"parent_id":null,"name":"Zoolander Coolness","description":"Zoolander Derek Zoolander School Heathered Royal Men's T-shirt","brand":"Zoolander","retailer":"Amazon.com","url":"http://www.amazon.com/Zoolander-Derek-School-Heathered-T-shirt/dp/B006UI5KUG/ref=sr_1_3?ie=UTF8","price":null,"comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/223/open-uri20120627-16385-1h6troz?1340829554","hashtags_allowed":true,"created_at":"2012-06-27T15:39:14-05:00","hashtags":[],"user":{"extract":{"id":12,"email":"aaronbartell@gmail.com","username":"aaronbartell@gmail.com","full_name":"Aaron","first_name":null,"last_name":null,"vanity_url":null,"country":"United States","biography":null,"notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":null,"zipcode":"56001","sex":true},"sex":"Male","avatar_url_small":"/assets/avatars/small/missing.png","avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":1},"flag_total":0,"flags":[]}
  # ::output-end::
  # Create item
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:poopydiaper -d "item[image]=http://ecx.images-amazon.com/images/I/51YeA77BaQL._SX342_.jpg" -d "item[retailer]=Amazon.com" -d "item[description]=Zoolander Derek Zoolander School Heathered Royal Men's T-shirt" -d "item[name]=Zoolander Coolness" -d "item[brand]=Zoolander" -d "item[url]=http://www.amazon.com/Zoolander-Derek-School-Heathered-T-shirt/dp/B006UI5KUG/ref=sr_1_3?ie=UTF8&qid=1340810439&sr=8-3&keywords=heathered+men+tshirt" localhost:3000/items.json</pre>  
  # =end
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

  # =begin apidoc
  # url:: /items/:id/relift.json
  # method:: POST
  # access:: FREE
  # return:: item object
  # param:: item object
  # output:: json
  # {"id":81,"parent_id":2,"name":"Item 2","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/2/product-large-2.jpg?1337212961","hashtags_allowed":true,"created_at":"2011-12-06T09:47:42-06:00","hashtags":[{"id":4,"value":"polo"}],"relift":{"created_at":"2012-06-27T15:44:12-05:00","user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":null,"sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":1}},"user":{"extract":{"id":12,"email":"aaronbartell@gmail.com","username":"aaronbartell@gmail.com","full_name":"Aaron","first_name":null,"last_name":null,"vanity_url":null,"country":"United States","biography":null,"notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":null,"zipcode":"56001","sex":true},"sex":"Male","avatar_url_small":"/assets/avatars/small/missing.png","avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":1},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]}
  # ::output-end::
  # Create item
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:poopydiaper localhost:3000/items/2/relift.json</pre>  
  # =end
  def relift
    authenticate_user!
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where(:id => params[:id], :status => 1).readonly(false).first!

    if !validate_item_results?
      return render_error(404,"Item not found")
    end

    @new_item = Item.new({:user_id => current_user.id, :post_id => @item.post.id, :parent_id => @item.id, :comment => params[:comment]})
    if @new_item.save
      @item.increment!(:relifts)
      @item.post.increment!(:relifts)
      render :partial => 'item', :locals => {:item => @new_item}, :status => 201
      if params[:hashtags]
        hashtags = params[:hashtags].include?(',') ? params[:hashtags].split(',') : params[:hashtags].split(' ')
      
        hashtags.each do |hashtag_value|   
          @hashtag_value = HashtagValue.where(:value => hashtag_value).first_or_create #.find_or_create_by_value(hashtag_value)
          if @hashtag_value.blank?
            # CONSIDER: post.errors[:base] << 'fails to create...' if entry_url.blank?
            return render_error(500,"Failed to create hashtag")
          end
          if !Hashtag.create({:user_id => current_user.id, :post_id => @item.post.id, :hashtag_value_id => @hashtag_value.id})
            return render_error(500,"Failed to create hashtag: "+hashtag_value+' '+@hashtag.errors[:hashtag_value_id][0])
          end
        end
      end      
      #TODO social media posts.
    else
      return_error_messages(@new_item,"Failed to relift item")
    end
  end

  # =begin apidoc
  # url:: /items/:id/edit.json
  # method:: POST
  # access:: FREE
  # return:: item object
  # param:: id:int - item id to update (URL)
  # param:: item object (POST content)
  # output:: json
  # {"id":77,"parent_id":null,"name":"Nicole Miller Strapless Gown | Bloomingdale's","description":"Zoolander Dereee","brand":"Nicole Miller","retailer":"www1.bloomingdales.com","url":"http://www1.bloomingdales.com/shop/product/nicole-miller-strapless-gown?ID=573044&CategoryID=21683#fn=DRESS_OCCASION%3DProm%26spp%3D2%26ppp%3D96%26sp%3D1%26rid%3D61","price":"1320.0","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/221/open-uri20120619-4539-q11om4?1340142491","hashtags_allowed":true,"created_at":"2012-06-19T16:47:52-05:00","hashtags":[],"user":{"extract":{"id":11,"email":"dondenoncourt@gmail.com","username":"dondenoncourt@gmail.com","full_name":"Don Denoncourt","first_name":null,"last_name":null,"vanity_url":null,"country":"United States","biography":null,"notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":null,"zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"/assets/avatars/small/missing.png","avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":2},"flag_total":0,"flags":[]} 
  # ::output-end::
  # Create item
  # <br/><br/>Notes:<pre>curl -X POST --user dondenoncourt@gmail.com:vo2max -d "item[description]=Zoolander Dereee" -d "item[image]=http://ecx.images-amazon.com/images/I/51YeA77BaQL._SX342_.jpg" localhost:3000/items/77/edit.json</pre>  
  # =end
  def update  
    authenticate_user!
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where("items.id = ? AND items.user_id = ? AND ISNULL(items.parent_id) AND items.status = 1",
                        params[:id],current_user.id).first!

    post = {:user_id => current_user.id}
    post_include = ["name", "description", "retailer", "url", "price", "comment", "hashtags_allowed"]

    if params[:item].blank?
      post_include.each do |element|
        post = post.merge({element => params[element]})
      end
      post[:brand]= Brand.find_or_create_by_name(params[:brand]) if !params[:brand].blank?
    else
      post_include.each do |element|
        post = post.merge({element => params[:item][element]})
      end
      post[:brand]= Brand.find_or_create_by_name(params[:item][:brand]) if !params[:item][:brand].blank?
    end
    
    # Delete any entries that are empty
    post.delete_if{ |k, v| v.nil? }
    if @item.post.update_attributes!(post)
      render :partial => 'item', :locals => {:item => @item}, :status => 200
    else    
      return_error_messages(@item,"Failed to update item")
    end
  end

  # =begin apidoc
  # url:: /items/:id/delete.json
  # method:: POST
  # access:: FREE
  # return:: item object
  # param:: id:int - item id to delete (URL)
  # output:: json
  # "Item successfully deleted"
  # ::output-end::
  # Delete item
  # <br/><br/>Notes:<pre>curl -X POST --user dondenoncourt@gmail.com:vo2max localhost:3000/items/77/delete</pre>  
  # =end
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

  def image
    @item = Item.find(params[:id])
  end

  # =begin apidoc
  # url:: /history/:id
  # method:: GET
  # access:: FREE
  # return:: item object
  # param:: id:int - item id to list history for
  # output:: json
  # {"id":1,"items_count":6,"items":[{"id":1,"created_at":"2011-12-19T23:04:53-06:00","user":{"id":1,"full_name":"Mark A. Roseboom","avatar":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1345218034"}},{"id":4,"created_at":"2011-12-19T23:04:53-06:00","user":{"id":2,"full_name":"Patrick Camacho","avatar":"http://s3.amazonaws.com/shoplift_dev/thumb/2/headless.jpg?1337213827"}},{"id":12,"created_at":"2011-12-19T23:04:53-06:00","user":{}},{"id":17,"created_at":"2012-06-01T04:07:07-05:00","user":{"id":6,"full_name":"Mike","avatar":"http://s3.amazonaws.com/shoplift_dev/thumb/6/Mike.jpg?1338540852"}},{"id":20,"created_at":"2012-06-01T08:07:51-05:00","user":{"id":7,"full_name":"Brandon Fail","avatar":"/assets/avatars/thumb/missing.png"}},{"id":23,"created_at":"2012-06-01T17:19:15-05:00","user":{"id":12,"full_name":"John Harrington","avatar":"http://s3.amazonaws.com/shoplift_dev/thumb/12/pgt_beauregard_sm.jpg?1338588970"}}],"first_lifter":{"created_at":"2011-12-06T09:46:45-06:00","id":1,"full_name":"Mark A. Roseboom","avatar":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1345218034"}}
  # ::output-end::
  # Show item history
  # <br/><br/>Notes:<pre> curl -X GET --user mark@elsewhere.net:vo2max localhost:3000/history/1.json</pre>  
  # =end
  def history
    @post = Post.find(params[:id])
    if @post != nil
      respond_to do |format|
        #format.html { render 'show'}
        format.json { render :partial => 'history', :status => 200 }
      end
    else
      render_error(404,"Item not found")
    end

  end

  def email
    @item = Item.find(params[:id])
    if @item != nil
      UserMailer.share(current_user, @item, params[:addresses], params[:subject], params[:thoughts]).deliver()
      respond_to do |format|
        format.json { render json:'{"response":"OK"}', :status => 200 }
      end
    else
      render_error(404,"Item not found")
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
