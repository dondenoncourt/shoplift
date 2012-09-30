class PageController < ApplicationController
  before_filter :authenticate_user!, :only => [:saved, :relift, :share, :report_tag, :report_item]

  layout nil, :only => [:upload_avatar, :report_tag, :report_item, :relift, :share]

  def home
    redirect_to root_path if user_signed_in?
    path = Rails.root.to_s + "/app/assets/images/galleria/images/*"
    @images = Dir.glob(path).collect{|f| File.basename(f)}
  end

  def ember
    if user_signed_in?
      render :layout => false
    else
      redirect_to page_home_path
    end
  end

  def landing
    render :layout => false
  end

  def saved
  end

  def buttons
    path = Rails.root.to_s + "/app/assets/images/galleria/images/*"
    @images = Dir.glob(path).collect{|f| File.basename(f)}
  end

  def relift
    @item = Item.find(params[:post_id])
  end

  def share
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

  def terms_of_service
  end

  def privacy
  end

  def contact
  end

  def about
    if Rails.env.production?
      @users = User.where('full_name IN (?)', ['John Harrington', 'Brandon Fail']).limit(2)
    else
      @users = [User.first, User.last]
    end
  end

  def emaildon
    email_don
    render text:'emailed'
  end

  private

  def email_don
    UserMailer.todon().deliver
  end

end
