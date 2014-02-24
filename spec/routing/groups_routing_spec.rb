require "spec_helper"

describe GroupsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/groups").to route_to("groups#index")
    end

    it "routes to #new" do
      expect(get: "/groups/new").to route_to("groups#new")
    end

    it "routes to #show" do
      expect(get: "/groups/1").to route_to("groups#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/groups/1/edit").to route_to("groups#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/groups").to route_to("groups#create")
    end

    it "routes to #update" do
      expect(put: "/groups/1").to route_to("groups#update", id: "1")
    end

    it "routes to #update" do
      expect(patch: "/groups/1").to route_to("groups#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/groups/1").to route_to("groups#destroy", id: "1")
    end

    it "routes to #add_user" do
      expect(post: "/groups/1/add_user").to route_to("groups#add_user", id: "1")
    end

    it "routes to #del_user" do
      expect(delete: "/groups/1/del_user").to route_to("groups#del_user", id: "1")
    end
  end
end
