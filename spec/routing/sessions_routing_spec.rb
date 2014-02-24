require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/signin").to route_to("sessions#new")
    end

    it "routes to #create" do
      expect(post: "/signin").to route_to("sessions#create")
    end

    it "routes to #destroy" do
      expect(get: "/signout").to route_to("sessions#destroy")
    end
  end
end
