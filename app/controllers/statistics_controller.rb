class StatisticsController < ApplicationController
  before_filter :authenticate_user!
    
  # =begin apidoc
  # url:: /statistics/users/:id.json
  # method:: GET
  # access:: FREE
  # return:: item
  # param:: id:int - User id
  # output:: json
  # {"total_items":2,"total_views":2,"total_visits":5,"total_relifts":2,"average_views_per_item":1,"average_visits_per_item":0,"average_relifts_per_item":1}
  # ::output-end::
  # Fetch statistics for users items
  # <br/><br/>Notes:<pre>curl -X GET --user mark@38media.net:vo2max localhost:3000/statistics/users/1.json</pre>  
  # =end
  def show_user
    
    @user = User.where(:id => params[:id], :status => 1).first!
    
    if @user.private
      authenticate_user!
      if !current_user.subscribed_to(@user)
        return render_error(404,"User Not Found")
      end
    end
    
    @items = Item.joins(:post,:user) \
                 .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                 .where("items.user_id = ? and items.status = 1",@user.id)
  end
  
  # =begin apidoc
  # url:: /statistics/items/:id.json
  # method:: GET
  # access:: FREE
  # return:: item
  # param:: id:int - Item id
  # output:: json
  # {"item":{"id":1,"parent_id":null,"name":"Item 1","description":"Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida, phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam, vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit, feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.","brand":"Lorem ipsum dolor sit amet","retailer":"Lorem ipsum dolor sit amet","url":"http://www.jcrew.com/index.jsp","price":"1.1","comment":null,"photo_url":"http://s3.amazonaws.com/shoplift_dev/small/1/product-large-1.jpg?1337212944","hashtags_allowed":true,"created_at":"2011-12-06T09:46:45-06:00","set_aside":{"created_at":"2011-12-19T23:04:53-06:00","id":1,"parent_id":1,"status":1,"updated_at":"2011-12-19T23:04:53-06:00","user_id":1},"hashtags":[{"id":1,"value":"jeans"},{"id":2,"value":"polo"}],"user":{"extract":{"id":1,"email":"mark@38media.net","username":"mark@38media.net","full_name":"Mark A. Roseboom","first_name":"Mark","last_name":"Roseboom","vanity_url":null,"country":null,"biography":"I like computers","notify_new_follower":null,"notify_relift":null,"notify_missing":null,"hometown":"Boston, MA","zipcode":null,"sex":true},"sex":"Male","avatar_url_small":"http://s3.amazonaws.com/shoplift_dev/small/1/bella_4.5_mths.jpg?1337213157","avatar_url_thumb":"http://s3.amazonaws.com/shoplift_dev/thumb/1/bella_4.5_mths.jpg?1337213157","followee_count":2},"flag_total":2,"flags":[{"flag_type":"It contains inappropriate language"},{"flag_type":"It's sold out / no longer available"}]},"statistics":{"views":2,"visits":5,"relifts":5,"total_views":3,"total_visits":5,"total_relifts":1}}
  # ::output-end::
  # Fetch statistics for items
  # <br/><br/>Notes:<pre>curl -X GET --user mark@38media.net:vo2max localhost:3000/statistics/items/1.json</pre>  
  # =end
  def show_item
    @item = Item.joins(:post,:user) \
                .joins("INNER JOIN users AS post_users on posts.user_id = post_users.id AND users.status = 1") \
                .where(:id => params[:id], :status => 1).first!
    
    if @item.user.id != current_user.id
      return render_error(404,'Item Not Found')
    end
  end
  
end
