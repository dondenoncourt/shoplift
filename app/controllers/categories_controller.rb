class CategoriesController < ApplicationController

  # =begin apidoc
  # url:: /categories.json
  # method:: GET
  # access:: FREE
  # return:: category object list
  # output:: json
  # {"categories":[{"created_at":"2012-05-31T15:13:17-05:00","id":1,"name":"Runway Fashion","param":"runway_fashion","updated_at":"2012-05-31T15:13:17-05:00"},{"created_at":"2012-05-31T15:13:17-05:00","id":2,"name":"Wear-to-work","param":"wear_to_work","updated_at":"2012-05-31T15:13:17-05:00"},{"created_at":"2012-05-31T15:13:17-05:00","id":3,"name":"School Clothes","param":"school_clothes","updated_at":"2012-05-31T15:13:17-05:00"},{"created_at":"2012-05-31T15:13:17-05:00","id":4,"name":"The Life of Leisure","param":"the_life_of_leisure","updated_at":"2012-05-31T15:13:17-05:00"},{"created_at":"2012-05-31T15:13:17-05:00","id":5,"name":"Beauty Products","param":"beauty_products","updated_at":"2012-05-31T15:13:17-05:00"},{"created_at":"2012-05-31T15:13:17-05:00","id":6,"name":"The Modern Home","param":"the_modern_home","updated_at":"2012-05-31T15:13:17-05:00"},{"created_at":"2012-05-31T15:13:17-05:00","id":7,"name":"Worthwhile Technology","param":"worthwhile_technology","updated_at":"2012-05-31T15:13:17-05:00"},{"created_at":"2012-05-31T15:13:17-05:00","id":8,"name":"Foodie Supplies","param":"foodie_supplies","updated_at":"2012-05-31T15:13:17-05:00"}]}
  # ::output-end::
  # List all categories
  # <br/><br/>Notes:<pre>curl -X GET --user aaronbartell@gmail.com:poopydiaper localhost:3000/categories.json</pre>
  # =end
  def index
    @categories = Category.all
    respond_to do |format|
      format.html { render :template => 'categories/index'}
      format.json { render :partial => 'categories', :locals => {:categories => @categories}, :status => 201 }
    end
  end

  def edit
    @category = Category.find(params[:id])
    @hashtags = HashtagValue.all
  end

  # =begin apidoc
  # url:: /categories/:id/update.json
  # method:: POST
  # access:: FREE
  # return:: category object
  # param:: id:int - Category id
  # param:: category:object - Category object in POST form variable format.
  # output:: json
  # {"created_at":"2012-05-31T15:13:17-05:00","id":2,"name":"Runway","param":"wear_to_work","updated_at":"2012-07-05T13:17:13-05:00"}
  # ::output-end::
  # Update category
  # <br/><br/>Notes:<pre>curl -X POST --user aaronbartell@gmail.com:poopydiaper -d "category[name]=Runway" localhost:3000/categories/2/update.json</pre>
  # =end
  def update
    authenticate_user!
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      respond_to do |format|
        format.html { redirect_to categories_path, :notice => "#{@category.name} has been updated." }
        format.json { render :json => @category, :status => 200 }
      end
    else
      render :edit
    end
  end
end
