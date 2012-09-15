class HashtagbrandsController < ApplicationController
  def index
    
    if params[:ids] && params[:ids] =~ /[\d\[\], ]*/ # be sure no hack injection
      ids = eval params[:ids]
      puts ids
      @hashtagbrands = Hashtagbrand.where(:id => ids)
    #else
      #@hashtagbrands = Hashtagbrand.scoped
    end

    puts @hashtagbrands.count
    #p @hashtagbrands

    render :partial => 'hashtagbrands/hashtagbrands'
  end

  def show
    @hashtagbrand = Hashtagbrand.find(params[:id])
  end
end
