class PageController < ApplicationController
  before_filter :authenticate_user!, :except => [:home, :terms_of_service]
  #after_filter :email_don

  layout nil, :only => [:upload_avatar, :report_tag, :report_item, :relift]

  def home
    redirect_to timelines_path if user_signed_in?
  end

  def saved
  end

  def relift
    @item = Item.find(params[:post_id])
  end

  def report_tag
    # all flag_types for hashtag domain
    @flagtypes = FlagType.find_all_by_domain_name('hashtag')
    @item = Item.find(params[:post_id])
    # all hashtags for a specific post
    @hashtags = Hashtag.joins(:post).where("post_id = ?", @item.post_id)
  end

  def report_item
    # all flag_types for post domain
    @flagtypes = FlagType.find_all_by_domain_name('post')
    # all hashtags for a specific post
    @item = Item.find(params[:post_id])
  end

  def follow_interests
    if current_user.created_at.to_date == Date.today &&
       Subscription.find_by_follower_id(current_user.id) == nil
        @new_user = true
    end
  end

  def terms_of_service
  end

  def privacy
  end

  private

  def email_don
    puts "ran home again in after_filter"
    UserMailer.todon().deliver
  end

end
