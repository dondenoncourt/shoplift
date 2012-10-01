require 'uri'

class ParserController < ApplicationController
  NoReferrer = Class.new(Exception)
  InvalidReferrer = Class.new(Exception)

  layout nil, :only => [:bookmarklet]

  def bookmarklet

    raise NoReferrer           unless url = request.referrer
    raise InvalidReferrer, url unless URI.parse(url).scheme


    parsed = Parser.parse(url)

    @brand  = parsed.delete(:brand)
    @images = parsed.delete(:images)

    post_scope = if current_user
      current_user.posts
    else
      # store on user session, and let the user know to login to claim post
      Post
    end

    @post = post_scope.create(parsed)

    @css  = render_to_string(:partial => 'style',  :layout => false).gsub(/\n/,'')
    @html = render_to_string(:partial => 'prompt', :layout => false).gsub(/\n/,'')
  end

  def dynascript

  end

  def brandscript
    brandNames = []
    Brand.where("name like ?", params[:prefix]+'%').order("posts_count DESC, name ASC").limit(10).each do |brand|
    #Brand.find(:all, conditions: ["name like ?", params[:prefix]+'%'], limit: 10).each do |brand|
      brandNames << brand.name
    end
    @brands = '['+ brandNames.map { |name| '"' + name.gsub(/&/, '&amp;').gsub(/'/, '&#39;') + '"' }.join(',') + ']'
  end
end
