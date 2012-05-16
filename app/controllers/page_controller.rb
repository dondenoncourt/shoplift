class PageController < ApplicationController
  before_filter :authenticate_user!

  layout "standard", :except => [:upload_avatar]

  def home
  end

  def saved
  end

  def profile_edit
  end

  def upload_avatar
  end
end
