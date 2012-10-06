require 'uri'

class ParserController < ApplicationController
  NoReferrer = Class.new(Exception)
  InvalidReferrer = Class.new(Exception)

  layout nil, :only => [:bookmarklet]

  def bookmarklet
  end

  def iframe

    url, uri = referrer

    raise NoReferrer           unless url
    raise InvalidReferrer, url unless uri.scheme

    parsed = Parser.parse(url)

    @brand  = parsed.delete(:brand)
    @images = parsed.delete(:images)

    post_scope = if current_user
      current_user.posts
    else
      # store on user session, and let the user know to login to claim post
      # all unclaimed posts will have a user_id of -1
      parsed[:user_id] = -1
      Post
    end

    @post = post_scope.create(parsed)
    @background =  params[:background]
    render layout: 'iframe'
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

  private

  def referrer
    url = params[:referrer] || request.referrer
    uri = URI.parse(url)

    [url, uri]
  end
end
