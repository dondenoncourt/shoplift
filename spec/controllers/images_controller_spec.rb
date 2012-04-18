require 'spec_helper'

describe ImagesController do
  
  before(:each) do
    @user = users(:users_001)
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Image" do
        sign_in @user
        expect {
          post :create, {:image => valid_attributes}, valid_session
        }.to change(Image, :count).by(1)
      end

      it "assigns a newly created image as @image" do
        post :create, {:image => valid_attributes}, valid_session
        assigns(:image).should be_a(Image)
        assigns(:image).should be_persisted
      end

      it "redirects to the created image" do
        post :create, {:image => valid_attributes}, valid_session
        response.should redirect_to(Image.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved image as @image" do
        # Trigger the behavior that occurs when invalid params are submitted
        Image.any_instance.stub(:save).and_return(false)
        post :create, {:image => {}}, valid_session
        assigns(:image).should be_a_new(Image)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Image.any_instance.stub(:save).and_return(false)
        post :create, {:image => {}}, valid_session
        response.should render_template("new")
      end
    end
  end


end
