class PostsController < ApplicationController
  include Parser
  include ParserAudit

  def new
    @post = current_user.posts.build
  end

  # =begin apidoc
  # url:: /post/create.json
  # method:: GET
  # access:: FREE
  # return:: create new post
  # param:: url:string - url
  # param:: retailer:string - retailer
  # param:: brand:string - brand
  # output:: json
  # {"brand_id":null,"comment":null,"created_at":"2012-06-28T14:59:46-05:00","description":"","hashtags_allowed":true,"id":224,"name":"Amazon.com: Zoolander Derek Zoolander School Heathered Royal Men's T-shirt: Clothing","photo_content_type":null,"photo_file_name":null,"photo_file_size":null,"photo_updated_at":null,"price":"18.73","relifts":0,"retailer":"www.amazon.com","status":1,"updated_at":"2012-06-28T14:59:46-05:00","url":"http://www.amazon.com/Zoolander-Derek-School-Heathered-T-shirt/dp/B006UI5KUG/ref=sr_1_3?ie=UTF8&qid=1340810439&sr=8-3&keywords=heathered men tshirt","user_id":11,"views":0,"visits":0}
  # ::output-end::
  # Create post
  # <br/><br/>Notes:<pre>curl -X GET --user dondenoncourt@gmail.com:vo2max localhost:3000/post/create.json?url=http%3A%2F%2Fwww.amazon.com%2FZoolander-Derek-School-Heathered-T-shirt%2Fdp%2FB006UI5KUG%2Fref%3Dsr_1_3%3Fie%3DUTF8%26qid%3D1340810439%26sr%3D8-3%26keywords%3Dheathered+men+tshirt</pre>  
  # =end
  def create
    authenticate_user!
    params[:url] = "http://"+params[:retailer]+params[:url] if !params[:url].include? 'http:'
    post_params = parse(params[:url])
    @brand_name = post_params[:brand]
    post_params[:brand] = nil
    @images = post_params.delete(:images)
    @post = current_user.posts.create(post_params)
    respond_to do |format|
      format.html { render :edit }
      format.js { render :json => @post }
      format.json { render :json => @post }
    end
  end

  def edit
  end

  # =begin apidoc
  # url:: /post/:id/update.json
  # method:: POST
  # access:: FREE
  # return:: update post
  # param:: id:int - post id
  # output:: json
  # 
  # ::output-end::
  # Create post
  # <br/><br/>Notes:<pre></pre>  
  # =end
  def update
    @post = Post.find(params[:id])
    if params[:image]
      image = (params[:image].include? 'http:') ? params[:image] : ("http://"+params[:post][:retailer]+'/'+params[:image])
      puts 'image:'+image
      @post.photo = open(image.gsub(/\s/, "%20"))
    end

    audit_params = Hash.new
    if params[:post][:brand] != params[:parser_brand]
      audit_params[:brand] = params[:post][:brand]
      audit_params[:name] = params[:post][:name]
    end
    if params[:post][:price] != params[:parser_price]
      audit_params[:price] = params[:post][:price]
    end

    if audit_params.length > 0
      audit_params[:url] = params[:post][:url]
      audit_params[:retailer] = params[:post][:retailer]
      audit_params[:parsed_name] = @post.name
      # TODO delay.parser_audit...
      parser_audit(audit_params)
    end
    
    @post.brand = Brand.find_or_create_by_name(params[:post][:brand])
    params[:post].delete(:brand)
    params[:post][:price] = params[:post][:price].gsub(/[^\d.]/, '') if params[:post][:price]
    
    if @post.update_attributes(params[:post])
      @item = @post.items.create({ :user_id => current_user.id })
      if @item.persisted?
        if params[:hashtags]
          params[:hashtags].each do |key, hashtag_value|
            puts 'adding hashtag:'+hashtag_value
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
        respond_to do |format|
          format.html { redirect_to current_user }
          format.json { render :partial => 'item', :locals => {:item => @item}, :status => 201 }
        end
      else
        render :edit
      end
    else
      render :edit
    end
  end

end
