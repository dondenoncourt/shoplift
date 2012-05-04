class PageController < ApplicationController
  before_filter :authenticate_user!
  def home
  end
  def saved
  end
end
