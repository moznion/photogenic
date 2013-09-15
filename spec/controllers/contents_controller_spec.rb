require 'spec_helper'

describe ContentsController do

  # This should return the minimal set of attributes required to create a valid
  # Content. As you add validations to Content, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET show" do
    it "assigns the requested content as @content" do
      content = Content.create! valid_attributes
      get :show, {:id => content.to_param}, valid_session
      assigns(:content).should eq(content)
    end
  end

  describe "GET new" do
    it "assigns a new content as @content" do
      get :new, {}, valid_session
      assigns(:content).should be_a_new(Content)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Content" do
        expect {
          post :create, {:content => valid_attributes}, valid_session
        }.to change(Content, :count).by(1)
      end

      it "assigns a newly created content as @content" do
        post :create, {:content => valid_attributes}, valid_session
        assigns(:content).should be_a(Content)
        assigns(:content).should be_persisted
      end

      it "redirects to the created content" do
        post :create, {:content => valid_attributes}, valid_session
        response.should redirect_to(Content.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved content as @content" do
        # Trigger the behavior that occurs when invalid params are submitted
        Content.any_instance.stub(:save).and_return(false)
        post :create, {:content => {  }}, valid_session
        assigns(:content).should be_a_new(Content)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Content.any_instance.stub(:save).and_return(false)
        post :create, {:content => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end
end
