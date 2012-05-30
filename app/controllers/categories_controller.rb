class CategoriesController < ApplicationController
  authorize_resource

  def index
    @categories = Category.all
    @new_user = current_user.created_at.to_date == Date.today && current_user.is_following_enough?
  end

  def edit
    @category = Category.find(params[:id])
    @hashtags = HashtagValue.all
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to categories_path, :notice => "#{@category.name} has been updated."
    else
      render :edit
    end
  end
end
