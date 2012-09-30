class SetAsidesController < ApplicationController
  before_filter :authenticate_user!


  # =begin apidoc
  # url:: /set_asides.json
  # method:: GET
  # access:: FREE
  # return:: set_asides list
  # output:: json
  # {"set_asides":[{"id":2,"parent_id":null,"name":"Item 2","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/2/product-large-2.jpg?1337212961","hashtags_allowed":true,"created_at":"2011-12-06T09:47:42-06:00","set_aside":{"created_at":"2012-06-15T12:48:17-05:00","id":19,"item_id":2,"status":1,"updated_at":"2012-06-15T12:48:17-05:00","user_id":11},"hashtags":[{"id":4,"value":"polo"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]},{"id":17,"parent_id":null,"name":"Shop Pedal-Powered Vehicles including Kettcars, Tractors & More | Kettler USA","description":null,"brand":"k","retailer":"www.kettlerusa.com","url":"/toys/pedal-vehicles","price":"279.0","comment":"d","photo_url":"http://s3.amazonaws.com/shoplift_dev/small/6/open-uri20120531-70819-1g55udt?1338496013","hashtags_allowed":true,"created_at":"2012-05-31T15:26:53-05:00","set_aside":{"created_at":"2012-06-15T15:22:24-05:00","id":32,"item_id":17,"status":1,"updated_at":"2012-06-15T15:22:24-05:00","user_id":11},"hashtags":[],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2},"flag_total":0,"flags":[]},{"id":71,"parent_id":null,"name":"Secret Wash end-on-end shirt","description":"Crisply tailored with an exceptional fit, it's the shirt every guy needs in his arsenal. Made of fine 100s two-ply cotton with a peached finish, it's incredibly soft, thanks to our Secret Wash. <ul><li>100s two-ply cotton.</li><li>Regular fit.</li><li>Button-down collar.</li><li>Machine wash.</li><li>Import.</li></ul>","brand":"J.Crew","retailer":"www.jcrew.com","url":"http://www.jcrew.com/AST/filterAsst/mens_shirt_collar/buttondown_collar/PRDOVR~78151/78151.jsp","price":"64.5","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/170/open-uri20120613-8715-3c9rbe?1339591353","hashtags_allowed":true,"created_at":"2012-06-13T07:42:17-05:00","set_aside":{"created_at":"2012-06-15T13:06:52-05:00","id":21,"item_id":71,"status":1,"updated_at":"2012-06-15T13:06:52-05:00","user_id":11},"hashtags":[{"id":22,"value":"plain wear"}],"user":{"extract":{"id":10,"email":"dondenoncourt@gmail.com","username":"dondenoncourt@gmail.com","full_name":"Don Denoncourt","first_name":null,"last_name":null,"vanity_url":null,"country":"United States","biography":"","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":null,"zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"/assets/avatars/small/missing.png","avatar_url_thumb":"/assets/avatars/thumb/missing.png","followee_count":2},"flag_total":0,"flags":[]}]}
  # ::output-end::
  # Fetch all set asides for current user
  # <br/><br/>Notes:<pre>curl -X GET --user aaronbartell@gmail.com:poopydiaper localhost:3000/set_asides.json</pre>
  # =end
  def index
    @set_asides = SetAside.joins(:post,:item,:user) \
                          .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                          .joins("INNER JOIN users AS item_users on items.user_id = item_users.id AND users.status = 1") \
                          .where("set_asides.user_id = ? AND set_asides.status = 1",current_user.id) \
                          .select("DISTINCT ON (items.id) set_asides.*")
  end

  # =begin apidoc
  # url:: /set_asides.json
  # method:: POST
  # access:: FREE
  # return:: set_aside that was created (with full DB relationships)
  # param:: item_id:int - id of item
  # output:: json
  # {"id":1,"parent_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","set_aside":{"created_at":"2012-06-19T14:45:37-05:00","id":33,"item_id":1,"status":1,"updated_at":"2012-06-19T14:45:37-05:00","user_id":11},"hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"},{"id":20,"value":"tie"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":"23238","sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2},"flag_total":1,"flags":[{"flag_type":"It contains inappropriate language"}]}
  # ::output-end::
  # Create set aside
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:poopydiaper -d "item_id=2" localhost:3000/set_asides.json</pre>
  # =end
  def create
    @item = Item.find(params[:item_id])

    if @item.user.private && !current_user.subscribed_to(@item.user)
      return render_error(404,"Item not found")
    end

    @set_aside = @item.set_asides.where(:user_id => current_user.id, :status => 1).first_or_create
    if @set_aside.persisted?
      if request.xhr?
        render :json => @set_aside, :locals => {:item => @set_aside.item}, :status => 201
      else
        render :partial => 'items/item', :locals => {:item => @set_aside.item}, :status => 201
      end
    else
      return_error_messages(@set_asides,"Item failed to save")
    end
  end

  # =begin apidoc
  # url:: /set_asides/items/:id/delete.json
  # method:: POST
  # access:: FREE
  # return:: set_aside that was deleted
  # param:: id:int - id of set_aside
  # output:: json
  # {"created_at":"2011-12-19T23:04:53-06:00","id":2,"item_id":2,"status":1,"updated_at":"2011-12-19T23:04:53-06:00","user_id":1}
  # ::output-end::
  # Delete set aside
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:poopydiaper localhost:3000/set_asides/items/2/delete.json</pre>
  # =end
  def destroy
    @set_aside = SetAside.where("id = ?",params[:id]).first!
    if @set_aside.delete
      render :json => @set_aside, :status => 200
    else
      return_error_messages(@set_aside,"Set aside delete failed")
    end
  end

end
