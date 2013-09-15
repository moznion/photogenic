require 'spec_helper'

describe ContentsController do

  let(:valid_attributes) { {  } }

  let(:valid_session) { {} }

  describe "GET new" do
    it "assigns a new content as @content" do
      get :new, {}, valid_session
      assigns(:content).should be_a_new(Content)
    end
  end

  describe "POST create" do
    it "should be rejected 'cuz it lacks params" do
      post :create, {}
      expect(assigns(:content)).to eql(nil)
    end
  end
end
