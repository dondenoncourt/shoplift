class HashtagbrandsController < ApplicationController

  def show
    @hashtagbrand = Hashtagbrand.find(params[:id])
  end
end
