require "rails_helper"

RSpec.describe Api::V1::BikesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "api/v1/bikes").to route_to("api/v1/bikes#index")
    end

    it "routes to #create" do
      expect(post: "api/v1/bikes").to route_to("api/v1/bikes#create")
    end

    it "routes to #update" do
      expect(put: "api/v1/bikes").to route_to("api/v1/bikes#update")
    end
  end
end
