class CategoriesController < ApplicationController
  authorize_resource

  def index
    @categories = Category.all
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
