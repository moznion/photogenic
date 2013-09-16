require "spec_helper"

describe ContentsController do
  describe "routing" do

    it "routes to #new" do
      get("/contents/new").should route_to("contents#new")
    end

    context "routes to #show" do
      it "full path" do
        get("/contents/1").should route_to("contents#show", :id => "1")
      end

      it "another path" do
        get("/item/1").should route_to("contents#show", :id => "1")
      end
    end

    it "routes to #create" do
      post("/contents").should route_to("contents#create")
    end

    it "root is #new" do
      get("/").should route_to("contents#new")
    end

  end
end
