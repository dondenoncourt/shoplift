class HashtagbrandsController < ApplicationController
  def index
    if params[:ids] && params[:ids] =~ /[\d\[\], ]*/ # be sure no hack injection
      ids = eval params[:ids]
      @hashtagbrands = Hashtagbrand.where(:id => ids)
    else
      return render_error 416, 'Error: an array of ids required'
    end
    render :partial => 'hashtagbrands/hashtagbrands'
  end

  def show
    @hashtagbrand = Hashtagbrand.find(params[:id])
  end
end
