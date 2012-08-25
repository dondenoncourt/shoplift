class ParserController < ApplicationController
  layout nil, :only => [:bookmarklet]
  include Parser

  def bookmarklet
    @css = render_to_string(:partial => 'style', :layout => false).gsub(/\n/,'')

    if current_user
      post_params = parse(params[:url])
      @brand_name = post_params[:brand]
      post_params[:brand] = nil
      @images = post_params.delete(:images)
      @post = current_user.posts.create(post_params)
    else
      @post = Post.new
    end

    @html = render_to_string(:partial => 'prompt', :layout => false).gsub(/\n/,'')
    #render :template => "parser/bookmarklet_old"
  end
  
end
