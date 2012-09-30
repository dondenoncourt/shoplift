class HashtagbrandsController < ApplicationController
  # =begin apidoc
  # url:: /hashtagbrands.json?ids=1,4,7
  # method:: GET
  # access:: FREE
  # return:: hashtagbrands list
  # param:: ids:array of int - required
  # output:: json
  # {"hashtagbrands":[{"id":1,"value":"Lorem ipsum dolor","image":"http://s3.amazonaws.com/shoplift/small/1/product-large-1.jpg?1337212944","item_ids":[1,4,12,17,20,23],"user_ids":[1,6,8,10,11,13,14,18,20,22]},{"id":2,"value":"New brand name","image":"http://s3.amazonaws.com/shoplift/small/2/product-large-2.jpg?1337212961","item_ids":[2,5,10,30],"user_ids":[3]},{"id":3,"value":"kettler","image":null,"item_ids":"[]","user_ids":[1]}]}
  # ::output-end::
  # Fetch all the hashtagbrands that have ids in the passed URI ids parameter
  # <br/><br/>Notes:<pre>curl -X GET --user mark@elsewhere.net:vo2max -d "ids=1,2,3" "localhost:3000/hashtagbrands.json"</pre>
  # =end
  def index
    authenticate_user!
    if params[:ids]
      @hashtagbrands = Hashtagbrand.where(:id => params[:ids])
    else
      return render_error 416, 'Error: an array of ids required'
    end
    render :partial => 'hashtagbrands/hashtagbrands'
  end

  # =begin apidoc
  # url:: /hashtagbrands/:id.json
  # method:: GET
  # access:: FREE
  # return:: hashtagbrands list
  # param:: ids:array of int - required
  # output:: json
  # {"hashtagbrand":{"id":1,"value":"Lorem ipsum dolor","image":"http://s3.amazonaws.com/shoplift/small/1/product-large-1.jpg?1337212944","item_ids":[1,4,12,17,20,23],"user_ids":[1,6,8,10,11,13,14,18,20,22]}}
  # ::output-end::
  # Fetch all the hashtagbrands that have ids in the passed URI ids parameter
  # <br/><br/>Notes:<pre>curl -X GET --user mark@elsewhere.net:vo2max "localhost:3000/hashtagbrands/2.json"</pre>
  # =end
  def show
    authenticate_user!
    @hashtagbrand = Hashtagbrand.find(params[:id])
  end

  # =begin apidoc
  # url:: /hashtagsbrands/search.json?query=:query
  # method:: GET
  # access:: FREE
  # return:: hashtags list
  # param:: search:string - search string value to be used on LIKE clause against table hashtag_values
  # output:: json
  # {"hashtagbrands":[{"brand_id":null,"created_at":null,"hashtag_value_id":1,"id":32768,"updated_at":null}]}
  # ::output-end::
  # Search hashtags
  # <br/><br/>Notes:<pre>curl -X GET --user mark@elsewhere.net:vo2max -d "query=jeans" "localhost:3000/hashtagbrands/search.json"</pre>
  # =end
  def search
    authenticate_user!
    @hashtagbrands = Hashtagbrand.includes(:brand, :hashtag_value).where("brands.name = :query or hashtag_values.value = :query",
                          :query => params[:query])
    render :json => @hashtagbrands, :status => 200
  end

  # =begin apidoc
  # url:: /hashtagsbrands/:id/relasted.json?limit=:limit
  # method:: GET
  # access:: FREE
  # return:: hashtagbrand list
  # param:: limit:int - limit the count of hashtagbrands returned, defaults to 5 (optional)
  # output:: json
  # {"hashtagbrands":[{"id":32787,"value":"BTFtag2"}]}
  # ::output-end::
  # Search hashtags
  # <br/><br/>Notes:<pre>curl -X GET --user mark@elsewhere.net:vo2max -d "limit=3" "localhost:3000/hashtagbrands/1/related.json"</pre>
  # =end
  def related
    hashtagbrand = Hashtagbrand.find(params[:id])
    if hashtagbrand
      limit = params[:limit] ||= 5
      @hashtagbrands = hashtagbrand.related(limit)
    else
      render_error 404, 'Hashtagbrand not found'
    end
  end

end
