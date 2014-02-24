require "spec_helper"

describe UsersController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/users").to route_to("users#index")
    end

    it "routes to #new" do
      expect(get: "/users/new").to route_to("users#new")
    end

    it "routes to #show" do
      expect(get: "/users/1").to route_to("users#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/users/1/edit").to route_to("users#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/users").to route_to("users#create")
    end

    it "routes to #update" do
      expect(put: "/users/1").to route_to("users#update", id: "1")
    end

    it "routes to #update" do
      expect(patch: "/users/1").to route_to("users#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/users/1").to route_to("users#destroy", id: "1")
    end

    it "routes to #search" do
      expect(get: "/users/search").to route_to("users#search")
    end

    it "routes to #home" do
      expect(get: "/home").to route_to("users#home")
    end

    it "routes to #profile" do
      expect(get: "/profile").to route_to("users#profile")
    end

    it "routes to #update_profile" do
      expect(patch: "/profile").to route_to("users#update_profile")
    end

    it "routes to #update_password" do
      expect(patch: "/password").to route_to("users#update_password")
    end
  end
end