class PostsController < ApplicationController
  include Parser

  def new
    @post = current_user.posts.build
  end

  def create
    authenticate_user!
    post_params = parse("http://"+params[:retailer]+params[:url])
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

    @post.photo = open(params[:image].gsub(/\s/, "%20")) if params[:image]
    if @post.update_attributes(params[:post])
      @item = @post.items.create({ :user_id => current_user.id })
      if @item.persisted?
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
