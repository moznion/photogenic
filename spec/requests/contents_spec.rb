require 'spec_helper'

describe "Contents" do
  describe "GET /contents/new" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/contents/new'
      response.status.should be(200)
    end
  end
end
