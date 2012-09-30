class FlagsController < ApplicationController
  before_filter :authenticate_user!

  # =begin apidoc
  # url:: /flags.json?:limit
  # method:: GET
  # access:: FREE
  # return:: item
  # param:: limit:int - limit the number of flags returned
  # output:: json
  # {"flags":[{"id":1,"flag_type":"It contains inappropriate language","hashtag_value":"jeans","item":{"id":1,"parent_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","set_aside":{"created_at":"2011-12-19T23:04:53-06:00","id":1,"parent_id":1,"status":1,"updated_at":"2011-12-19T23:04:53-06:00","user_id":1},"hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":null,"sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]}}]}
  # ::output-end::
  # Fetch all flags for current user
  # <br/><br/>Notes:<pre>curl -X GET --user mark@38media.net:vo2max localhost:3000/flags.json</pre>
  # =end
  def index
    limit = params[:limit].blank? ? 20 : params[:limit]

    @post_flags = PostFlag.joins(:items,:user) \
                          .where("post_flags.status = 1 AND items.user_id = #{current_user.id} AND posts.user_id = #{current_user.id}") \
                          .order("items.created_at DESC").limit(limit)

     @hashtag_flags = HashtagFlag.joins(:items,:user) \
                                 .where("hashtag_flags.status = 1 AND items.user_id = #{current_user.id} AND posts.user_id = #{current_user.id}") \
                                 .order("items.created_at DESC").limit(limit)

    raise ActiveRecord::RecordNotFound unless !@post_flags.blank? || !@hashtag_flags.blank?
  end

  # =begin apidoc
  # url:: /flags/items/:id.json
  # method:: POST
  # access:: FREE
  # return:: post_flag object
  # param:: id:int - item id
  # param:: flag_type_id:int - FlagType id
  # param:: post_id:int - post id
  # param:: user_id:int - user id
  # output:: json
  # {"id":5,"flag_type":"It's sold out / no longer available","item":{"id":1,"parent_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","set_aside":{"created_at":"2011-12-19T23:04:53-06:00","id":1,"parent_id":1,"status":1,"updated_at":"2011-12-19T23:04:53-06:00","user_id":1},"hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":null,"sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2},"flag_total":2,"flags":[{"flag_type":"It contains inappropriate language"},{"flag_type":"It's sold out / no longer available"}]}}
  # ::output-end::
  # Create flag for item
  # <br/><br/>Notes:<pre>curl -X POST --user mark@38media.net:vo2max -d "flag_type_id=4" -d "post_id=1" -d "user_id=1" localhost:3000/flags/items/1.json</pre>
  # =end
  def create_item
    @post_flag = PostFlag.new(:flag_type_id => params[:flag_type_id], :post_id => Item.find(params[:id]).post.id, :user_id => current_user.id)
    if @post_flag.save
      render :partial => 'post_flags/post_flag', :locals => {:post_flag => @post_flag}, :status => 201
    else
      return_error_messages(@post_flag,"Could not create item flag")
    end
  end

  # =begin apidoc
  # url:: /flags/hashtags/:id.json
  # method:: POST
  # access:: FREE
  # return:: post_flag object
  # param:: id:int - Hashtag id
  # param:: flag_type_id:int - FlagType id
  # param:: post_id:int - post id
  # param:: user_id:int - user id
  # output:: json
  # {"id":4,"flag_type":"It's misleading or dishonest","hashtag_value":"jeans","item":{"id":1,"parent_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","set_aside":{"created_at":"2011-12-19T23:04:53-06:00","id":1,"parent_id":1,"status":1,"updated_at":"2011-12-19T23:04:53-06:00","user_id":1},"hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":null,"sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2},"flag_total":2,"flags":[{"flag_type":"It contains inappropriate language"},{"flag_type":"It's sold out / no longer available"}]}}
  # ::output-end::
  # Create flag for hashtag
  # <br/><br/>Notes:<pre>curl -X POST --user mark@38media.net:vo2max -d "flag_type_id=5" -d "post_id=1" -d "user_id=1" localhost:3000/flags/hashtags/1.json</pre>
  # =end
  def create_hashtag
    @hashtag_flag = HashtagFlag.new(:flag_type_id => params[:flag_type_id], :hashtag_id => params[:id], :user_id => current_user.id)
    if @hashtag_flag.save
      render :partial => 'hashtag_flags/hashtag_flag', :locals => {:hashtag_flag => @hashtag_flag}, :status => 201
    else
      return_error_messages(@hashtag_flag,"Could not create hashtag flag")
    end
  end

end
