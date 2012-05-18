class PageController < ApplicationController
  before_filter :authenticate_user!

  layout "standard", :except => [:upload_avatar, :report_tag]

  def home
  end

  def saved
  end

  def profile_edit
  end

  def upload_avatar
  end

  def report_tag
    # all flag_types for hashtag domain
    @flagtypes = FlagType.find_all_by_domain_name('hashtag')
    # all hashtags for a specific post
    @item = Item.find(params[:post_id])
    @hashtags = Hashtag.joins(:post).where("post_id = ?", @item.post_id)
  end
end
