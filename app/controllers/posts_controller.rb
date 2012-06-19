class PostsController < ApplicationController
  include Parser

  def new
    @post = current_user.posts.build
  end

  def create
    authenticate_user!
    params[:url] = "http://"+params[:retailer]+params[:url] if !params[:url].include? 'http:'
    post_params = parse(params[:url])
    @images = post_params.delete(:images)
    @post = current_user.posts.create(post_params)
    respond_to do |format|
      format.html { render :edit }
      format.js { render :json => @post }
    end
  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
    if params[:image]
      image = (params[:image].include? 'http:') ? params[:image] : ("http://"+params[:retailer]+'/'+params[:image])
      puts 'image:'+image
      @post.photo = open(image.gsub(/\s/, "%20"))
    end

    @post.brand = Brand.find_or_create_by_name(params[:brand])
    
# for parser_audit:
# would have to update_attributes manually so we can save modified attributes
# "learn" what has changed
# by looping through params[:post].each {|k, v| 
# delay.parser_audit...
    if @post.update_attributes(params[:post])
      @item = @post.items.create({ :user_id => current_user.id })
      if @item.persisted?
        if params[:hashtags]
          # TODO: change to the new syntax: .where (:value => hashtag_value).first_or_create
          params[:hashtags].each do |key, hashtag_value|
            puts 'adding hashtag:'+hashtag_value
            @hashtag_value = HashtagValue.find_or_create_by_value(hashtag_value)
            if @hashtag_value.blank?
              # post.errors[:base] << 'fails to create...' if entry_url.blank?
              return render_error(500,"Failed to create hashtag")
            end
            # TODO change to Hashtag.create so a new and save both are not needed
            @hashtag = Hashtag.new({:user_id => current_user.id, :post_id => @item.post.id, :hashtag_value_id => @hashtag_value.id})
            if !@hashtag.save
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
