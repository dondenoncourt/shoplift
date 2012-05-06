class PageController < ApplicationController
  before_filter :authenticate_user!

  layout "standard"

  def home
  end

  def saved
  end
end
