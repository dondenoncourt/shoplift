class PageController < ApplicationController
  before_filter :authenticate_user!
  #after_filter :email_don

  layout "standard", :except => [:upload_avatar, :report_tag, :report_item, :relift]

  def home
    #if current_user.created_at.to_date() == Date.today
      #redirect_to controller:'page', action:'follow_interests', new_user:'true'
    #end
  end

  def saved
  end

  def profile_edit
  end

  def upload_avatar
  end

  def follow
    @users = User.where('status = 1').limit(50).offset(0)
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
    @new_user = params[:new_user]
  end

  private

  def email_don
    puts "ran home again in after_filter"
    UserMailer.todon().deliver
  end
end
