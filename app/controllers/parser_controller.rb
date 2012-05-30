class ParserController < ApplicationController
  layout nil, :only => [:bookmarklet]
  
  # Parse url
  # * *Request*    :
  #   - GET /parse
  # * *Args*    :
  #   - :url -> URL of page to be parsed
  def parse
    # Authenticate user
    authenticate_user!
    
    # Gem for determine image size on the fly
    require 'fastimage'
    
    # Set variables::
    params[:url] = "http://www.amazon.com/HP-658553-001-ProLiant-Server-System/dp/B005KKJPCO/ref=sr_1_3?ie=UTF8&qid=1330188488&sr=8-3"
    @results = {:title => "", :description => "", :price => [], :brand => "", :retailer => params[:url].split('/')[2], :images => [], :hashtags => []}
    
    # Parse contents
    html = Nokogiri::HTML(open(params[:url]))
    
    # Find title 
    @results[:title] = html.xpath('//meta[@property="og:title"]')
    if !@results[:title].blank?
       @results[:title] = @results[:title].first.attr("content")
    else
      @results[:title] = html.title
    end
    
    # Find description
    @results[:description] = html.xpath('//meta[@property="og:description"]')
    if !@results[:description].blank?
      @results[:description] = @results[:description].first.attr("content")
    else
      @results[:description] = html.xpath('//meta[@name="description"]')
      if !@results[:description].blank?
        @results[:description] = @results[:description].first.attr("content")
      else
        @results[:description] = html.at_css("*[id*='desc']")
        if !@results[:description].blank?
          @results[:description] = @results[:description].text
        else
          @results[:description] = html.at_css("*[class*='desc']")
          if !@results[:description].blank?
            @results[:description] = @results[:description].text
          end  
        end
      end  
    end
    
    # Find brand
    @results[:brand] = html.xpath('//meta[@property="og:site_name"]')
    if !@results[:brand].blank?
      @results[:brand] = @results[:brand].first.attr("content")
    else
      @results[:brand] = html.at_css("*[id*='brand']")
      if !@results[:brand].blank?
        @results[:brand] = @results[:brand].text
      end
    end
    
    # Find price
    @results[:price] = html.text.scan(/\$[0-9\.]+/)
    if !@results[:price].blank? && @results[:price].count == 1
      @results[:price] = @results[:price].text
    else  
      @results[:price] = html.at_css("*[id*='price']")
      if !@results[:price].blank?
        @results[:price] = @results[:price].text[/\$[0-9\.]+/]
      else
        @results[:price] = html.at_css("*[class*='price']")
        if !@results[:price].blank?
          @results[:price] = @results[:price].text[/\$[0-9\.]+/]
        end
      end  
    end
    
    # Find images large than 200x200px
    html.xpath('//img').each do |img_tag|
      if img_tag.attributes.first[1].value[0,4] == "http"
        size = FastImage.size(img_tag.attributes.first[1].value)
        if size[0] >= 150 && size[1] >= 150
          @results[:images] << img_tag.attributes.first[1].value
        end
      else
        begin
          size = FastImage.size(@results[:retailer]+img_tag.attributes.first[1].value)
          if size.blank?
            next
          else
            if size[0] >= 150 && size[1] >= 150
              @results[:images] << img_tag.attributes.first[1].value
            end 
          end
        rescue URI::InvalidURIError
          next
        end
      end
    end

    # Find hashtags and camelcase
    hashtags = html.xpath('//meta[@name="keywords"]')
    if !hashtags.blank?
      hashtags = hashtags.first.attr("content")
      hashtags = hashtags.split(",")
      hashtags.each do |hashtag|
        hashtag = hashtag.squish.gsub(/[^[:alnum:]]/,'').gsub(' ','_')
        if hashtag.length < 40
          @results[:hashtags] << hashtag.camelcase
        end  
      end
    end
    
    render :json => @results, :status => 200
  end 

  def bookmarklet
    authenticate_user!
  end
  
end
