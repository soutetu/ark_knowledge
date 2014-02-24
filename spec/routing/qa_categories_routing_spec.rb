require "spec_helper"

describe QaCategoriesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/qa_categories").to route_to("qa_categories#index")
    end

    it "routes to #show" do
      expect(get: "/qa_categories/1").to route_to("qa_categories#show", id: "1")
    end

    it "routes to #new" do
      expect(get: "/qa_categories/new").to route_to("qa_categories#new")
    end

    it "routes to #edit" do
      expect(get: "/qa_categories/1/edit").to route_to("qa_categories#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/qa_categories").to route_to("qa_categories#create")
    end

    it "routes to #update" do
      expect(put: "/qa_categories/1").to route_to("qa_categories#update", id: "1")
    end

    it "routes to #update" do
      expect(patch: "/qa_categories/1").to route_to("qa_categories#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/qa_categories/1").to route_to("qa_categories#destroy", id: "1")
    end

    it "routes to #add_user" do
      expect(post: "/qa_categories/1/add_user").to route_to("qa_categories#add_user", id: "1")
    end

    it "routes to #del_user" do
      expect(delete: "/qa_categories/1/del_user").to route_to("qa_categories#del_user", id: "1")
    end
  end
end
