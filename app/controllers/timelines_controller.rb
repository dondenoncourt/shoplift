class TimelinesController < ApplicationController

  # =begin apidoc
  # url:: /timelines.json&page=2
  # method:: GET
  # access:: FREE
  # return:: timeline list
  # param:: page:int - the page, default is 1 (optional)
  # output:: json
  # {"timeline":[{"id":1,"parent_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"},{"id":20,"value":"tie"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]},{"id":4,"parent_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"},{"id":20,"value":"tie"}],"user":{"extract":{"id":2,"email":"patrick@38media.net","username":"patrick@38media.net","full_name":"Patrick Camacho","first_name":"Patrick","last_name":"Camacho","vanity_url":"http://38media.net","country":"United States","biography":"I like dogs","notify_new_follower":true,"notify_relift":false,"notify_missing":"daily","hometown":"Waltham, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/2/headless.jpg?1337213827","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/2/headless.jpg?1337213827","followee_count":2},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]}]}
  # ::output-end::
  # Fetch items of current user and that of his/her subscriptions.  Defaults 2 per page.
  # <br/><br/>Notes:<pre></pre>  
  # =end
  def index
    authenticate_user!
    @items = Item.joins(:post,:user,"INNER JOIN subscriptions ON subscriptions.user_id = items.user_id AND subscriptions.status = 1")
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1")
                 .where("items.status = 1 AND (subscriptions.follower_id = ? )",current_user.id)
                 .between(params)
                 .order("items.created_at DESC")
                 .group("items.id")
                 .paginate(per_page: 2, page: params[:page])

    render partial: @items if request.xhr?
  end

  # =begin apidoc
  # url:: /timelines/users/:id.json?limit=2
  # method:: GET
  # access:: FREE
  # return:: timeline list
  # param:: id:int - User id
  # param:: limit:int - Number of items to return  
  # output:: json
  # {"timeline":[{"id":74,"parent_id":17,"name":"Shop Pedal-Powered Vehicles including Kettcars, Tractors & More | Kettler USA","description":null,"brand":"k","retailer":"www.kettlerusa.com","url":"/toys/pedal-vehicles","price":"279.0","comment":"d","photo_url":"http://s3.amazonaws.com/shoplift_dev/small/6/open-uri20120531-70819-1g55udt?1338496013","hashtags_allowed":true,"created_at":"2012-05-31T15:26:53-05:00","hashtags":[],"relift":{"created_at":"2012-06-19T13:06:22-05:00","user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2}},"user":{"extract":{"id":11,"email":"aaronbartell@gmail.com","username":"aaronbartell@gmail.com","full_name":"aaron","first_name":null,"last_name":null,"vanity_url":null,"country":"United States","biography":"","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":null,"zipcode":"56001","sex":true},"sex":"Male","avatar_url_small":"/assets/avatars/small/missing.png","avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":2},"flag_total":0,"flags":[]}]}
  # ::output-end::
  # Fetch up to 50 items of a specified user
  # <br/><br/>Notes:<pre></pre>  
  # =end
  def show_user
    @user = User.find(params[:id])

    if @user.private
      authenticate_user!
      if !current_user.subscribed_to(@user)
        return render_error(404,"User not found")
      end
    end

    if !params[:limit].blank? && params[:limit].to_i >= 50
      return render_error(406,"Limit must be less than or equal to 50")
    end

    @items = Item.joins(:post,:user) \
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                 .where("items.status = 1 AND items.user_id = ?",@user.id) \
                 .between(params)
                 .order("items.created_at DESC") \
                 .group("items.id") \
                 .limit(limit)
     render :index
  end

  # =begin apidoc
  # url:: /timelines/recent.json?limit=1
  # method:: GET
  # access:: FREE
  # return:: timeline list
  # param:: id:int - User id
  # param:: limit:int - Number of items to return  
  # output:: json
  # {"timeline":[{"id":74,"parent_id":17,"name":"Shop Pedal-Powered Vehicles including Kettcars, Tractors & More | Kettler USA","description":null,"brand":"k","retailer":"www.kettlerusa.com","url":"/toys/pedal-vehicles","price":"279.0","comment":"d","photo_url":"http://s3.amazonaws.com/shoplift_dev/small/6/open-uri20120531-70819-1g55udt?1338496013","hashtags_allowed":true,"created_at":"2012-05-31T15:26:53-05:00","hashtags":[],"relift":{"created_at":"2012-06-19T13:06:22-05:00","user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2}},"user":{"extract":{"id":11,"email":"aaronbartell@gmail.com","username":"aaronbartell@gmail.com","full_name":"aaron","first_name":null,"last_name":null,"vanity_url":null,"country":"United States","biography":"","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":null,"zipcode":"56001","sex":true},"sex":"Male","avatar_url_small":"/assets/avatars/small/missing.png","avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":2},"flag_total":0,"flags":[]}]}
  # ::output-end::
  # Fetch up to 50 of the most recent items posted
  # <br/><br/>Notes:<pre></pre>  
  # =end
  def show_recent
    if !params[:limit].blank? && params[:limit].to_i >= 50
      return render_error(406,"Limit must be less than or equal to 50")
    end

    @items = Item.joins(:post,:user) \
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                 .where("items.status = 1 AND users.private != 1") \
                 .between(params)
                 .order("items.created_at DESC") \
                 .group("items.id") \
                 .limit(limit)
     render :index

  end

  # =begin apidoc
  # url:: /timelines/hashtags/:name.json?limit=1
  # method:: GET
  # access:: FREE
  # return:: timeline list
  # param:: id:int - User id
  # param:: limit:int - Number of items to return  
  # output:: json
  # {"timeline":[{"id":74,"parent_id":17,"name":"Shop Pedal-Powered Vehicles including Kettcars, Tractors & More | Kettler USA","description":null,"brand":"k","retailer":"www.kettlerusa.com","url":"/toys/pedal-vehicles","price":"279.0","comment":"d","photo_url":"http://s3.amazonaws.com/shoplift_dev/small/6/open-uri20120531-70819-1g55udt?1338496013","hashtags_allowed":true,"created_at":"2012-05-31T15:26:53-05:00","hashtags":[],"relift":{"created_at":"2012-06-19T13:06:22-05:00","user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2}},"user":{"extract":{"id":11,"email":"aaronbartell@gmail.com","username":"aaronbartell@gmail.com","full_name":"aaron","first_name":null,"last_name":null,"vanity_url":null,"country":"United States","biography":"","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":null,"zipcode":"56001","sex":true},"sex":"Male","avatar_url_small":"/assets/avatars/small/missing.png","avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":2},"flag_total":0,"flags":[]}]}
  # ::output-end::
  # Fetch unlimited items that match hashtag name. Default count retruned is 20 (if that many exist)
  # <br/><br/>Notes:<pre></pre>  
  # =end
  def show_hashtags
    limit = params[:limit].blank? ? 20 : params[:limit]
    @items = Item.joins(:post,:user,:hashtags,:hashtag_values) \
                  .where("items.status = 1 AND hashtag_values.value = ?",params[:name]) \
                  .order("items.created_at DESC") \
                  .group("items.id") \
                  .limit(limit)
    render :index
  end

  private

  def limit
    params[:limit] || 20
  end

end
